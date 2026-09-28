class Funcionario {


  final int? id;

  final String nome;

  final String? telefone;

  final String? email;

  final String? funcao;

  final String? foto;

  final String estado;

  final DateTime criadoEm;

  final DateTime? atualizadoEm;




  Funcionario({

    this.id,

    required this.nome,

    this.telefone,

    this.email,

    this.funcao,

    this.foto,

    this.estado = "Ativo",

    required this.criadoEm,

    this.atualizadoEm,

  });






  // =====================================================
  // MAP -> OBJETO
  // =====================================================


  factory Funcionario.fromMap(

    Map<String, dynamic> map,

  ) {


    return Funcionario(


      id: map['id'],


      nome: map['nome'],


      telefone: map['telefone'],


      email: map['email'],


      funcao: map['funcao'],


      foto: map['foto'],


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


      'funcao': funcao,


      'foto': foto,


      'estado': estado,


      'criado_em':

          criadoEm.toIso8601String(),


      'atualizado_em':

          atualizadoEm?.toIso8601String(),


    };


  }









  // =====================================================
  // COPY WITH
  // =====================================================


  Funcionario copyWith({


    int? id,

    String? nome,

    String? telefone,

    String? email,

    String? funcao,

    String? foto,

    String? estado,

    DateTime? criadoEm,

    DateTime? atualizadoEm,


  }) {


    return Funcionario(


      id:

          id ?? this.id,


      nome:

          nome ?? this.nome,


      telefone:

          telefone ?? this.telefone,


      email:

          email ?? this.email,


      funcao:

          funcao ?? this.funcao,


      foto:

          foto ?? this.foto,


      estado:

          estado ?? this.estado,


      criadoEm:

          criadoEm ?? this.criadoEm,


      atualizadoEm:

          atualizadoEm ?? this.atualizadoEm,


    );


  }









  // =====================================================
  // JSON
  // =====================================================


  Map<String, dynamic> toJson() {


    return toMap();


  }





  factory Funcionario.fromJson(

    Map<String, dynamic> json,

  ) {


    return Funcionario.fromMap(json);


  }



}