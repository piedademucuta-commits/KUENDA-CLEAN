import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  DatabaseHelper._();

  static final DatabaseHelper instance =
      DatabaseHelper._();


  static Database? _database;



  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }




  Future<Database> _initDatabase() async {

    final path = join(
      await getDatabasesPath(),
      'kuenda_clean.db',
    );


    return openDatabase(

      path,

      version: 4,

      onCreate: _createDatabase,

      onUpgrade: _upgradeDatabase,

    );

  }




  Future<void> _upgradeDatabase(

      Database db,

      int oldVersion,

      int newVersion,

      ) async {


    if(oldVersion < 3){

      await db.execute('''
      CREATE TABLE IF NOT EXISTS administradores(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        senha TEXT NOT NULL
      )
      ''');


      await db.insert(

        'administradores',

        {
          'nome':'Administrador',
          'email':'admin@kuendaclean.com',
          'senha':'123456',
        },

        conflictAlgorithm:
        ConflictAlgorithm.ignore,

      );

    }



    if(oldVersion < 4){

      try{

        await db.execute(
          'ALTER TABLE clientes ADD COLUMN foto TEXT'
        );

      }catch(_){}

    }


  }







  Future<void> _createDatabase(

      Database db,

      int version,

      ) async {


    await db.execute('''
    
    CREATE TABLE clientes(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      telefone TEXT,

      email TEXT UNIQUE NOT NULL,

      endereco TEXT,

      senha TEXT NOT NULL,

      foto TEXT

    )

    ''');





    await db.execute('''
    
    CREATE TABLE administradores(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      email TEXT UNIQUE NOT NULL,

      senha TEXT NOT NULL

    )

    ''');





    await db.insert(

      'administradores',

      {

        'nome':'Administrador',

        'email':'admin@kuendaclean.com',

        'senha':'123456',

      },

    );






    await db.execute('''

    CREATE TABLE funcionarios(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      telefone TEXT,

      funcao TEXT

    )

    ''');






    await db.execute('''

    CREATE TABLE pedidos(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      cliente TEXT NOT NULL,

      servico TEXT NOT NULL,

      endereco TEXT NOT NULL,

      data TEXT NOT NULL,

      horario TEXT NOT NULL,

      observacao TEXT,

      estado TEXT NOT NULL

    )

    ''');


  }






// =====================================================
// CLIENTES
// =====================================================


Future<int> inserirCliente(
    Map<String,dynamic> cliente
) async {

  final db = await database;

  return db.insert(
    'clientes',
    cliente,
  );

}




Future<List<Map<String,dynamic>>> listarClientes() async {

  final db = await database;

  return db.query(
    'clientes',
    orderBy:'id DESC',
  );

}




Future<Map<String,dynamic>?> loginCliente(

    String email,

    String senha

) async {


  final db = await database;


  final result = await db.query(

    'clientes',

    where:
    'email=? AND senha=?',

    whereArgs:[
      email,
      senha,
    ],

  );


  return result.isEmpty
      ? null
      : result.first;

}



Future<Map<String, dynamic>?> obterClientePorEmail(
  String email,
) async {
  final db = await database;

  final resultado = await db.query(
    'clientes',
    where: 'email=?',
    whereArgs: [email],
    limit: 1,
  );

  if (resultado.isEmpty) {
    return null;
  }

  return resultado.first;
}
Future<int> atualizarCliente(

    int id,

    Map<String,dynamic> dados

) async {


  final db = await database;


  return db.update(

    'clientes',

    dados,

    where:'id=?',

    whereArgs:[id],

  );

}




Future<int> atualizarFotoCliente(

    int id,

    String foto

) async {

  return atualizarCliente(

    id,

    {
      'foto':foto
    },

  );

}





Future<int> removerCliente(int id) async {

  final db = await database;


  return db.delete(

    'clientes',

    where:'id=?',

    whereArgs:[id],

  );

}



// compatibilidade

Future<int> eliminarCliente(int id){

  return removerCliente(id);

}








// =====================================================
// ADMIN
// =====================================================


Future<int> insertAdmin(

Map<String,dynamic> admin

) async {


final db = await database;


return db.insert(

'administradores',

admin,

);

}






Future<Map<String,dynamic>?> loginAdmin(

String email,

String senha

) async {


final db = await database;


final result = await db.query(

'administradores',

where:'email=? AND senha=?',

whereArgs:[
email,
senha
],

);


return result.isEmpty
? null
: result.first;

}






Future<int> atualizarAdministrador(

int id,

Map<String,dynamic> dados

) async {


final db = await database;


return db.update(

'administradores',

dados,

where:'id=?',

whereArgs:[id],

);

}








// =====================================================
// FUNCIONÁRIOS
// =====================================================


Future<int> inserirFuncionario(

Map<String,dynamic> funcionario

) async {


final db = await database;


return db.insert(

'funcionarios',

funcionario,

);

}




Future<int> criarFuncionario(

Map<String,dynamic> funcionario

){

return inserirFuncionario(funcionario);

}






Future<List<Map<String,dynamic>>> listarFuncionarios() async {


final db = await database;


return db.query(

'funcionarios',

orderBy:'id DESC',

);

}





Future<int> atualizarFuncionario(

int id,

Map<String,dynamic> dados

) async {


final db = await database;


return db.update(

'funcionarios',

dados,

where:'id=?',

whereArgs:[id],

);

}






Future<int> removerFuncionario(int id) async {


final db = await database;


return db.delete(

'funcionarios',

where:'id=?',

whereArgs:[id],

);

}



Future<int> eliminarFuncionario(int id){

return removerFuncionario(id);

}









// =====================================================
// DASHBOARD
// =====================================================


Future<int> contarClientes() async {

final db = await database;

final result =
await db.rawQuery(
'SELECT COUNT(*) FROM clientes'
);

return Sqflite.firstIntValue(result) ?? 0;

}




Future<int> contarPedidos() async {

final db = await database;

final result =
await db.rawQuery(
'SELECT COUNT(*) FROM pedidos'
);

return Sqflite.firstIntValue(result) ?? 0;

}




Future<int> contarFuncionarios() async {

final db = await database;

final result =
await db.rawQuery(
'SELECT COUNT(*) FROM funcionarios'
);

return Sqflite.firstIntValue(result) ?? 0;

}




Future<int> contarPedidosPendentes() async {

final db = await database;

final result =
await db.rawQuery(

'''
SELECT COUNT(*)
FROM pedidos
WHERE estado=?
''',

['Pendente']

);


return Sqflite.firstIntValue(result) ?? 0;

}








// =====================================================
// PEDIDOS
// =====================================================


Future<int> inserirPedido(

Map<String,dynamic> pedido

) async {


final db = await database;


return db.insert(

'pedidos',

pedido,

);

}





Future<List<Map<String,dynamic>>> listarPedidos() async {


final db = await database;


return db.query(

'pedidos',

orderBy:'id DESC',

);

}






Future<List<Map<String,dynamic>>> listarPedidosCliente(

String cliente

) async {


final db = await database;


return db.query(

'pedidos',

where:'cliente=?',

whereArgs:[cliente],

orderBy:'id DESC',

);

}





Future<int> atualizarEstadoPedido(

int id,

String estado

) async {


final db = await database;


return db.update(

'pedidos',

{
'estado':estado
},

where:'id=?',

whereArgs:[id],

);

}





Future<int> removerPedido(int id) async {


final db = await database;


return db.delete(

'pedidos',

where:'id=?',

whereArgs:[id],

);

}





Future<void> close() async {


if(_database != null){

await _database!.close();

_database=null;

}


}


}