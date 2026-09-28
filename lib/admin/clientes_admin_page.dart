import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';





class ClientesAdminPage extends StatefulWidget {

  const ClientesAdminPage({super.key});


  @override
  State<ClientesAdminPage> createState() =>
      _ClientesAdminPageState();

}





class _ClientesAdminPageState
    extends State<ClientesAdminPage> {



  List<Map<String,dynamic>> clientes = [];



  @override
  void initState() {

    super.initState();

    carregarClientes();

  }






  Future<void> carregarClientes() async {


    final dados =

    await DatabaseHelper.instance
        .listarClientes();



    setState(() {


      clientes = dados;


    });


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:

        const Text(

          'Clientes',

        ),

      ),




      floatingActionButton:

      FloatingActionButton(

        onPressed: () {

          novoCliente();

        },


        child:

        const Icon(

          Icons.person_add,

        ),

      ),





      body:

      clientes.isEmpty

          ?

      const Center(

        child:

        Text(

          'Nenhum cliente cadastrado',

        ),

      )


          :

      ListView.builder(


        itemCount:

        clientes.length,


        itemBuilder:

            (context,index){



          final cliente =
          clientes[index];



          return Card(


            margin:

            const EdgeInsets.all(10),



            child:

            ListTile(



              leading:

              CircleAvatar(

                child:

                Text(

                  cliente['nome']

                      .substring(0,1)

                      .toUpperCase(),

                ),

              ),




              title:

              Text(

                cliente['nome'],

              ),




              subtitle:

              Text(

                cliente['telefone'],

              ),





              trailing:

              IconButton(


                icon:

                const Icon(

                  Icons.delete,

                ),



                onPressed: () async {



                  await DatabaseHelper.instance

                      .removerCliente(

                    cliente['id'],

                  );



                  carregarClientes();



                },


              ),


            ),


          );


        },


      ),


    );


  }








  void novoCliente(){


    final nome =
    TextEditingController();


    final telefone =
    TextEditingController();


    final email =
    TextEditingController();


    final endereco =
    TextEditingController();




    showDialog(


      context: context,


      builder: (dialogContext) {



        return AlertDialog(



          title:

          const Text(

            'Novo Cliente',

          ),




          content:

          SingleChildScrollView(


            child:

            Column(


              children: [


                campo(
                  nome,
                  'Nome',
                ),


                campo(
                  telefone,
                  'Telefone',
                ),


                campo(
                  email,
                  'Email',
                ),


                campo(
                  endereco,
                  'Endereço',
                ),


              ],


            ),

          ),




          actions: [



            ElevatedButton(

              onPressed: () async {



                await DatabaseHelper.instance

                    .inserirCliente({



                  'nome':

                  nome.text,



                  'telefone':

                  telefone.text,



                  'email':

                  email.text,



                  'endereco':

                  endereco.text,



                });



                if (!dialogContext.mounted) {
                  return;
                }

                Navigator.pop(dialogContext);



                carregarClientes();



              },


              child:

              const Text(

                'Salvar',

              ),


            ),


          ],


        );

      },

    );


  }







  Widget campo(

      TextEditingController controller,

      String texto,

      ){

    return TextField(

      controller: controller,

      decoration:

      InputDecoration(

        labelText: texto,

      ),

    );

  }



}
