import 'package:flutter/material.dart';



class FuncionariosAdminPage extends StatefulWidget {

  const FuncionariosAdminPage({super.key});


  @override
  State<FuncionariosAdminPage> createState() =>
      _FuncionariosAdminPageState();

}



class _FuncionariosAdminPageState
    extends State<FuncionariosAdminPage> {



  // Futuramente será substituído por dados do SQLite

  final List<Map<String, String>> funcionarios = [];



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:

        const Text(

          'Funcionários',

        ),

        centerTitle: true,

      ),




      floatingActionButton:

      FloatingActionButton(

        onPressed: () {

          _novoFuncionario(context);

        },


        child:

        const Icon(

          Icons.person_add,

        ),


      ),





      body:


      funcionarios.isEmpty


          ? _listaVazia()


          : ListView.builder(


        padding:

        const EdgeInsets.all(15),



        itemCount:

        funcionarios.length,



        itemBuilder:

            (context, index) {



          final funcionario =
          funcionarios[index];



          return Card(


            elevation:3,


            child: ListTile(


              leading:

              CircleAvatar(


                child:

                Text(

                  funcionario['nome']!

                      .substring(0,1)

                      .toUpperCase(),

                ),


              ),




              title:

              Text(

                funcionario['nome']!,

                style:

                const TextStyle(

                  fontWeight:

                  FontWeight.bold,

                ),

              ),




              subtitle:

              Text(

                '${funcionario['funcao']} \n'
                    '${funcionario['telefone']}',

              ),



              isThreeLine:

              true,




              trailing:

              IconButton(


                icon:

                const Icon(

                  Icons.delete,

                ),



                onPressed: () {



                  setState(() {


                    funcionarios.removeAt(index);


                  });



                },


              ),



            ),


          );



        },


      ),


    );


  }








  Widget _listaVazia() {


    return const Center(


      child:

      Column(


        mainAxisAlignment:

        MainAxisAlignment.center,


        children: [



          Icon(

            Icons.badge_outlined,

            size:80,

            color:Colors.grey,

          ),



          SizedBox(height:20),



          Text(

            'Nenhum funcionário cadastrado',

            style:

            TextStyle(

              fontSize:18,

              color:Colors.grey,

            ),

          ),



        ],


      ),


    );


  }








  void _novoFuncionario(BuildContext context) {


    final nomeController =
    TextEditingController();


    final telefoneController =
    TextEditingController();


    final funcaoController =
    TextEditingController();





    showDialog(


      context: context,


      builder: (_) {



        return AlertDialog(



          title:

          const Text(

            'Novo Funcionário',

          ),




          content:

          SingleChildScrollView(


            child:

            Column(


              mainAxisSize:

              MainAxisSize.min,



              children: [



                TextField(

                  controller:

                  nomeController,


                  decoration:

                  const InputDecoration(

                    labelText:

                    'Nome',

                  ),

                ),




                TextField(

                  controller:

                  telefoneController,


                  keyboardType:

                  TextInputType.phone,


                  decoration:

                  const InputDecoration(

                    labelText:

                    'Telefone',

                  ),

                ),




                TextField(

                  controller:

                  funcaoController,


                  decoration:

                  const InputDecoration(

                    labelText:

                    'Função',

                  ),

                ),



              ],


            ),

          ),





          actions: [



            TextButton(


              onPressed: () {


                Navigator.pop(context);


              },


              child:

              const Text(

                'Cancelar',

              ),


            ),





            ElevatedButton(


              onPressed: () {



                if(nomeController.text.isNotEmpty){



                  setState(() {


                    funcionarios.add({



                      'nome':

                      nomeController.text,



                      'telefone':

                      telefoneController.text,



                      'funcao':

                      funcaoController.text,



                    });



                  });



                }



                Navigator.pop(context);



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


}