import 'package:flutter/material.dart';


class ConfirmacaoPage extends StatelessWidget {


  final String nome;
  final String telefone;
  final String localizacao;


  const ConfirmacaoPage({

    super.key,

    required this.nome,

    required this.telefone,

    required this.localizacao,

  });





  @override
  Widget build(BuildContext context){


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Pedido enviado"
        ),

        centerTitle:true,

      ),




      body:Center(


        child:Padding(

          padding:const EdgeInsets.all(20),


          child:Column(

            mainAxisAlignment:
            MainAxisAlignment.center,


            children:[



              const Icon(

                Icons.check_circle,

                color:Colors.green,

                size:100,

              ),




              const SizedBox(height:20),




              const Text(

                "Pedido recebido com sucesso!",

                style:TextStyle(

                  fontSize:22,

                  fontWeight:FontWeight.bold,

                ),

                textAlign:TextAlign.center,

              ),




              const SizedBox(height:20),




              Text(

                "Cliente: $nome\n"
                "Telefone: $telefone\n"
                "Localização: $localizacao",

                textAlign:TextAlign.center,

              ),




              const SizedBox(height:30),




              ElevatedButton(

                onPressed:(){

                  Navigator.popUntil(

                    context,

                    (route)=>route.isFirst,

                  );

                },

                child:const Text(

                  "Novo pedido",

                ),

              )


            ],

          ),

        ),


      ),


    );


  }


}