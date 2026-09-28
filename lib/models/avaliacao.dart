class Avaliacao {


  final int? id;

  final int clienteId;

  final int pedidoId;

  final int nota;

  final String? comentario;

  final DateTime criadoEm;





  Avaliacao({

    this.id,

    required this.clienteId,

    required this.pedidoId,

    required this.nota,

    this.comentario,

    required this.criadoEm,

  });








  // =====================================================
  // MAP -> OBJETO
  // =====================================================


  factory Avaliacao.fromMap(

    Map<String, dynamic> map,

  ) {


    return Avaliacao(


      id:

          map['id'],


      clienteId:

          map['cliente_id'],


      pedidoId:

          map['pedido_id'],


      nota:

          map['nota'],


      comentario:

          map['comentario'],


      criadoEm:

          DateTime.parse(

            map['criado_em'],

          ),


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


      'pedido_id':

          pedidoId,


      'nota':

          nota,


      'comentario':

          comentario,


      'criado_em':

          criadoEm.toIso8601String(),


    };


  }









  // =====================================================
  // COPY WITH
  // =====================================================


  Avaliacao copyWith({


    int? id,

    int? clienteId,

    int? pedidoId,

    int? nota,

    String? comentario,

    DateTime? criadoEm,


  }) {


    return Avaliacao(


      id:

          id ?? this.id,


      clienteId:

          clienteId ?? this.clienteId,


      pedidoId:

          pedidoId ?? this.pedidoId,


      nota:

          nota ?? this.nota,


      comentario:

          comentario ?? this.comentario,


      criadoEm:

          criadoEm ?? this.criadoEm,


    );


  }









  // =====================================================
  // JSON
  // =====================================================


  Map<String, dynamic> toJson() {


    return toMap();


  }





  factory Avaliacao.fromJson(

    Map<String, dynamic> json,

  ) {


    return Avaliacao.fromMap(json);


  }



}