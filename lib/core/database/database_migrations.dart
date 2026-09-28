import 'package:sqflite/sqflite.dart';


class DatabaseMigrations {



  static Future<void> migrate(

    Database db,

    int oldVersion,

    int newVersion,

  ) async {



    if (oldVersion < 2) {

      await _version2(db);

    }



    if (oldVersion < 3) {

      await _version3(db);

    }



    if (oldVersion < 4) {

      await _version4(db);

    }



    if (oldVersion < 5) {

      await _version5(db);

    }



  }









  // =====================================================
  // VERSÃO 2
  // Dados adicionais de acesso
  // =====================================================


  static Future<void> _version2(

    Database db,

  ) async {



    await _addColumn(

      db,

      "clientes",

      "ultimo_login",

      "TEXT",

    );





    await _addColumn(

      db,

      "administradores",

      "ultimo_login",

      "TEXT",

    );



  }









  // =====================================================
  // VERSÃO 3
  // Sistema de notificações
  // =====================================================


  static Future<void> _version3(

    Database db,

  ) async {



    await db.execute('''

    CREATE TABLE IF NOT EXISTS notificacoes (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      utilizador_id INTEGER NOT NULL,

      tipo_usuario TEXT NOT NULL,

      titulo TEXT NOT NULL,

      mensagem TEXT NOT NULL,

      lida INTEGER DEFAULT 0,

      criado_em TEXT NOT NULL

    )

    ''');



  }









  // =====================================================
  // VERSÃO 4
  // Apoio ao cliente
  // =====================================================


  static Future<void> _version4(

    Database db,

  ) async {



    await db.execute('''

    CREATE TABLE IF NOT EXISTS suporte (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      telefone TEXT,

      whatsapp TEXT,

      email TEXT,

      horario TEXT,

      atualizado_em TEXT

    )

    ''');





    await db.insert(

      "suporte",

      {

        "telefone": "",

        "whatsapp": "",

        "email": "",

        "horario": "08:00 - 18:00",

        "atualizado_em":

            DateTime.now().toIso8601String(),

      },

      conflictAlgorithm:

          ConflictAlgorithm.ignore,

    );



  }









  // =====================================================
  // VERSÃO 5
  // Permissões administrativas
  // =====================================================


  static Future<void> _version5(

    Database db,

  ) async {



    await _addColumn(

      db,

      "administradores",

      "nivel_acesso",

      "TEXT DEFAULT 'admin'",

    );





    await _addColumn(

      db,

      "administradores",

      "estado",

      "TEXT DEFAULT 'Ativo'",

    );



  }









  // =====================================================
  // MÉTODO AUXILIAR
  // Adicionar coluna sem quebrar banco existente
  // =====================================================


  static Future<void> _addColumn(

    Database db,

    String tabela,

    String coluna,

    String tipo,

  ) async {



    try {



      await db.execute(

        '''

        ALTER TABLE $tabela

        ADD COLUMN $coluna $tipo

        ''',

      );



    } catch (e) {



      // A coluna já existe.

    }



  }




}