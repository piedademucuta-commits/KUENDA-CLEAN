class Administrador {


  final int? id;

  final String nome;

  final String? telefone;

  final String? email;

  final String passwordHash;

  final String? pinHash;

  final String? foto;

  final String? codigoVerificacao;

  final DateTime? codigoExpiracao;

  final bool contaVerificada;

  final String nivelAcesso;

  final String estado;

  final DateTime criadoEm;

  final DateTime? atualizadoEm;

  final DateTime? ultimoLogin;




  Administrador({

    this.id,

    required this.nome,

    this.telefone,

    this.email,

    required this.passwordHash,

    this.pinHash,

    this.foto,

    this.codigoVerificacao,

    this.codigoExpiracao,

    this.contaVerificada = true,

    this.nivelAcesso = "admin",

    this.estado = "Ativo",

    required this.criadoEm,

    this.atualizadoEm,

    this.ultimoLogin,

  });







  // =====================================================
  // MAP -> OBJETO
  // =====================================================


  factory Administrador.fromMap(

    Map<String, dynamic> map,

  ) {


    return Administrador(


      id: map['id'],


      nome: map['nome'],


      telefone: map['telefone'],


      email: map['email'],


      passwordHash:

          map['password_hash'],


      pinHash:

          map['pin_hash'],


      foto:

          map['foto'],


      codigoVerificacao:

          map['codigo_verificacao'],


      codigoExpiracao:

          map['codigo_expiracao'] != null

              ? DateTime.parse(

                  map['codigo_expiracao'],

                )

              : null,



      contaVerificada:

          map['conta_verificada'] == 1,



      nivelAcesso:

          map['nivel_acesso'] ?? "admin",



      estado:

          map['estado'] ?? "Ativo",



      criadoEm:

          DateTime.parse(

            map['criado_em'],

          ),



      atualizadoEm:

          map['atualizado_em'] != null

              ? DateTime.parse(

                  map['atualizado_em'],

                )

              : null,



      ultimoLogin:

          map['ultimo_login'] != null

              ? DateTime.parse(

                  map['ultimo_login'],

                )

              : null,


    );


  }









  // =====================================================
  // OBJETO -> MAP
  // =====================================================


  Map<String, dynamic> toMap() {


    return {


      'id': id,


      'nome': nome,


      'telefone': telefone,


      'email': email,


      'password_hash':

          passwordHash,


      'pin_hash':

          pinHash,


      'foto':

          foto,


      'codigo_verificacao':

          codigoVerificacao,


      'codigo_expiracao':

          codigoExpiracao

              ?.toIso8601String(),


      'conta_verificada':

          contaVerificada ? 1 : 0,



      'nivel_acesso':

          nivelAcesso,



      'estado':

          estado,



      'criado_em':

          criadoEm

              .toIso8601String(),



      'atualizado_em':

          atualizadoEm

              ?.toIso8601String(),



      'ultimo_login':

          ultimoLogin

              ?.toIso8601String(),


    };


  }









  // =====================================================
  // COPY WITH
  // =====================================================


  Administrador copyWith({


    int? id,

    String? nome,

    String? telefone,

    String? email,

    String? passwordHash,

    String? pinHash,

    String? foto,

    String? codigoVerificacao,

    DateTime? codigoExpiracao,

    bool? contaVerificada,

    String? nivelAcesso,

    String? estado,

    DateTime? criadoEm,

    DateTime? atualizadoEm,

    DateTime? ultimoLogin,


  }) {


    return Administrador(


      id: id ?? this.id,


      nome:

          nome ?? this.nome,


      telefone:

          telefone ?? this.telefone,


      email:

          email ?? this.email,


      passwordHash:

          passwordHash ?? this.passwordHash,


      pinHash:

          pinHash ?? this.pinHash,


      foto:

          foto ?? this.foto,


      codigoVerificacao:

          codigoVerificacao ??

          this.codigoVerificacao,


      codigoExpiracao:

          codigoExpiracao ??

          this.codigoExpiracao,


      contaVerificada:

          contaVerificada ??

          this.contaVerificada,


      nivelAcesso:

          nivelAcesso ??

          this.nivelAcesso,


      estado:

          estado ??

          this.estado,


      criadoEm:

          criadoEm ??

          this.criadoEm,


      atualizadoEm:

          atualizadoEm ??

          this.atualizadoEm,


      ultimoLogin:

          ultimoLogin ??

          this.ultimoLogin,


    );


  }









  // =====================================================
  // JSON
  // =====================================================


  Map<String, dynamic> toJson() {


    return toMap();


  }





  factory Administrador.fromJson(

    Map<String, dynamic> json,

  ) {


    return Administrador.fromMap(json);


  }



}