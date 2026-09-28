import 'package:sqflite/sqflite.dart';


class DatabaseTables {



  static Future<void> createAll(Database db) async {


    await _createClientes(db);


    await _createAdministradores(db);


    await _createFuncionarios(db);


    await _createPedidos(db);


    await _createAvaliacoes(db);


    await _createCodigosVerificacao(db);


    await _createSessoes(db);



  }





  // =====================================================
  // CLIENTES
  // =====================================================

  static Future<void> _createClientes(Database db) async {


    await db.execute('''

    CREATE TABLE clientes (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      telefone TEXT UNIQUE,

      email TEXT UNIQUE,

      password_hash TEXT NOT NULL,

      pin_hash TEXT,

      foto TEXT,

      codigo_verificacao TEXT,

      codigo_expiracao TEXT,

      conta_verificada INTEGER DEFAULT 0,

      criado_em TEXT NOT NULL,

      atualizado_em TEXT

    )

    ''');


  }







  // =====================================================
  // ADMINISTRADORES
  // =====================================================

  static Future<void> _createAdministradores(Database db) async {


    await db.execute('''

    CREATE TABLE administradores (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      telefone TEXT UNIQUE,

      email TEXT UNIQUE,

      password_hash TEXT NOT NULL,

      pin_hash TEXT,

      foto TEXT,

      codigo_verificacao TEXT,

      codigo_expiracao TEXT,

      conta_verificada INTEGER DEFAULT 1,

      criado_em TEXT NOT NULL,

      atualizado_em TEXT

    )

    ''');


  }








  // =====================================================
  // FUNCIONÁRIOS
  // =====================================================

  static Future<void> _createFuncionarios(Database db) async {


    await db.execute('''

    CREATE TABLE funcionarios (

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      nome TEXT NOT NULL,

      telefone TEXT,

      email TEXT,

      funcao TEXT,

      foto TEXT,

      estado TEXT DEFAULT 'Ativo',

      criado_em TEXT NOT NULL,

      atualizado_em TEXT

    )

    ''');


  }








  // =====================================================
  // PEDIDOS
  // =====================================================

  static Future<void> _createPedidos(Database db) async {


    await db.execute('''

    CREATE TABLE pedidos (

      id INTEGER PRIMARY KEY AUTOINCREMENT,


      cliente_id INTEGER NOT NULL,


      funcionario_id INTEGER,


      servico TEXT NOT NULL,


      descricao TEXT,


      endereco TEXT NOT NULL,


      data_servico TEXT NOT NULL,


      valor REAL DEFAULT 0,


      estado TEXT DEFAULT 'Pendente',


      forma_pagamento TEXT,


      criado_em TEXT NOT NULL,


      atualizado_em TEXT,



      FOREIGN KEY(cliente_id)

      REFERENCES clientes(id)

      ON DELETE CASCADE,



      FOREIGN KEY(funcionario_id)

      REFERENCES funcionarios(id)

      ON DELETE SET NULL


    )

    ''');


  }








  // =====================================================
  // AVALIAÇÕES
  // =====================================================

  static Future<void> _createAvaliacoes(Database db) async {


    await db.execute('''

    CREATE TABLE avaliacoes (

      id INTEGER PRIMARY KEY AUTOINCREMENT,


      cliente_id INTEGER NOT NULL,


      pedido_id INTEGER NOT NULL,


      nota INTEGER NOT NULL,


      comentario TEXT,


      criado_em TEXT NOT NULL,



      FOREIGN KEY(cliente_id)

      REFERENCES clientes(id)

      ON DELETE CASCADE,



      FOREIGN KEY(pedido_id)

      REFERENCES pedidos(id)

      ON DELETE CASCADE


    )

    ''');


  }








  // =====================================================
  // CÓDIGOS DE VERIFICAÇÃO / RECUPERAÇÃO
  // =====================================================

  static Future<void> _createCodigosVerificacao(Database db) async {


    await db.execute('''

    CREATE TABLE codigos_verificacao (

      id INTEGER PRIMARY KEY AUTOINCREMENT,


      utilizador_id INTEGER NOT NULL,


      tipo_usuario TEXT NOT NULL,


      codigo TEXT NOT NULL,


      finalidade TEXT NOT NULL,


      expiracao TEXT NOT NULL,


      utilizado INTEGER DEFAULT 0,


      criado_em TEXT NOT NULL


    )

    ''');


  }








  // =====================================================
  // SESSÕES
  // =====================================================

  static Future<void> _createSessoes(Database db) async {


    await db.execute('''

    CREATE TABLE sessoes (

      id INTEGER PRIMARY KEY AUTOINCREMENT,


      utilizador_id INTEGER NOT NULL,


      tipo_usuario TEXT NOT NULL,


      token TEXT NOT NULL,


      criado_em TEXT NOT NULL,


      expiracao TEXT


    )

    ''');


  }



}