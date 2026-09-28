class ClienteModel {

  final int? id;

  final String nome;

  final String telefone;

  final String email;

  final String endereco;



  ClienteModel({

    this.id,

    required this.nome,

    required this.telefone,

    required this.email,

    required this.endereco,

  });





  Map<String, dynamic> toMap() {

    return {

      'id': id,

      'nome': nome,

      'telefone': telefone,

      'email': email,

      'endereco': endereco,

    };

  }





  factory ClienteModel.fromMap(
      Map<String, dynamic> map
      ) {

    return ClienteModel(

      id: map['id'],

      nome: map['nome'],

      telefone: map['telefone'] ?? '',

      email: map['email'] ?? '',

      endereco: map['endereco'] ?? '',

    );

  }

}