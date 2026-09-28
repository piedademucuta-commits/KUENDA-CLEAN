class Pedido {


  final int? id;

  final int clienteId;

  final int? funcionarioId;

  final String servico;

  final String? descricao;

  final String endereco;

  final DateTime dataServico;

  final double valor;

  final String estado;

  final String? formaPagamento;

  final DateTime criadoEm;

  final DateTime? atualizadoEm;




  Pedido({

    this.id,

    required this.clienteId,

    this.funcionarioId,

    required this.servico,

    this.descricao,

    required this.endereco,

    required this.dataServico,

    this.valor = 0,

    this.estado = "Pendente",

    this.formaPagamento,

    required this.criadoEm,

    this.atualizadoEm,

  });







  // =====================================================
  // MAP -> OBJETO
  // =====================================================


  factory Pedido.fromMap(

    Map<String, dynamic> map,

  ) {


    return Pedido(


      id: map['id'],


      clienteId:

          map['cliente_id'],


      funcionarioId:

          map['funcionario_id'],


      servico:

          map['servico'],


      descricao:

          map['descricao'],


      endereco:

          map['endereco'],


      dataServico:

          DateTime.parse(

            map['data_servico'],

          ),



      valor:

          (map['valor'] ?? 0)

              .toDouble(),



      estado:

          map['estado'] ?? "Pendente",



      formaPagamento:

          map['forma_pagamento'],



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


      'cliente_id':

          clienteId,


      'funcionario_id':

          funcionarioId,



      'servico':

          servico,



      'descricao':

          descricao,



      'endereco':

          endereco,



      'data_servico':

          dataServico.toIso8601String(),



      'valor':

          valor,



      'estado':

          estado,



      'forma_pagamento':

          formaPagamento,



      'criado_em':

          criadoEm.toIso8601String(),



      'atualizado_em':

          atualizadoEm?.toIso8601String(),


    };


  }









  // =====================================================
  // COPY WITH
  // =====================================================


  Pedido copyWith({


    int? id,

    int? clienteId,

    int? funcionarioId,

    String? servico,

    String? descricao,

    String? endereco,

    DateTime? dataServico,

    double? valor,

    String? estado,

    String? formaPagamento,

    DateTime? criadoEm,

    DateTime? atualizadoEm,


  }) {


    return Pedido(


      id:

          id ?? this.id,


      clienteId:

          clienteId ?? this.clienteId,


      funcionarioId:

          funcionarioId ?? this.funcionarioId,


      servico:

          servico ?? this.servico,


      descricao:

          descricao ?? this.descricao,


      endereco:

          endereco ?? this.endereco,


      dataServico:

          dataServico ?? this.dataServico,


      valor:

          valor ?? this.valor,


      estado:

          estado ?? this.estado,


      formaPagamento:

          formaPagamento ?? this.formaPagamento,


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





  factory Pedido.fromJson(

    Map<String, dynamic> json,

  ) {


    return Pedido.fromMap(json);


  }



}