import 'dart:io';

import 'package:flutter/material.dart';
import '../core/database/database_helper.dart';

import 'package:image_picker/image_picker.dart';





class FuncionariosPage extends StatefulWidget {


  const FuncionariosPage({

    super.key,

  });



  @override
  State<FuncionariosPage> createState() =>
      _FuncionariosPageState();


}







class _FuncionariosPageState
    extends State<FuncionariosPage> {



  List<Map<String,dynamic>> funcionarios = [];



  @override
  void initState(){

    super.initState();

    carregarFuncionarios();

  }








  Future<void> carregarFuncionarios() async {


    final lista =

    await DatabaseHelper.instance
        .listarFuncionarios();



    if(!mounted)return;



    setState((){


      funcionarios = lista;


    });



  }









  Future<String?> escolherFoto() async {


    final picker = ImagePicker();



    final imagem =

    await picker.pickImage(

      source: ImageSource.gallery,

      imageQuality:80,

    );



    return imagem?.path;


  }









  Future<void> abrirFormulario({

    Map<String,dynamic>? funcionario,

  }) async {



    final nomeController = TextEditingController(

      text: funcionario?['nome'] ?? "",

    );



    final telefoneController = TextEditingController(

      text: funcionario?['telefone'] ?? "",

    );



    final funcaoController = TextEditingController(

      text: funcionario?['funcao'] ?? "",

    );



    String estado =

    funcionario?['estado'] ?? "Ativo";



    String? foto =

    funcionario?['foto'];






    await showDialog(



      context: context,


      builder:(context){



        return StatefulBuilder(



          builder:(context,setDialogState){



            return AlertDialog(



              title:

              Text(

                funcionario==null

                    ?

                "Novo funcionário"

                    :

                "Editar funcionário",

              ),





              content:

              SingleChildScrollView(



                child:

                Column(



                  children:[



                    GestureDetector(



                      onTap:() async {



                        final novaFoto =

                        await escolherFoto();



                        if(novaFoto!=null){


                          setDialogState((){


                            foto=novaFoto;


                          });



                        }



                      },




                      child:

                      CircleAvatar(



                        radius:45,



                        backgroundImage:

                        foto!=null &&
                            foto!.isNotEmpty


                            ?

                        FileImage(
                            File(foto!)
                        )


                            :

                        null,




                        child:

                        foto==null ||
                            foto!.isEmpty


                            ?

                        const Icon(

                          Icons.person,

                          size:45,

                        )

                            :

                        null,



                      ),



                    ),





                    const SizedBox(height:15),






                    TextField(


                      controller:nomeController,


                      decoration:

                      const InputDecoration(

                        labelText:"Nome",

                      ),


                    ),





                    TextField(


                      controller:
                      telefoneController,


                      decoration:

                      const InputDecoration(

                        labelText:"Telefone",

                      ),



                    ),





                    TextField(


                      controller:
                      funcaoController,


                      decoration:

                      const InputDecoration(

                        labelText:"Função",

                      ),



                    ),







                    DropdownButtonFormField(


                      initialValue:estado,


                      items:[


                        "Ativo",

                        "Inativo"


                      ].map((e){


                        return DropdownMenuItem(


                          value:e,


                          child:Text(e),


                        );


                      }).toList(),



                      onChanged:(valor){



                        setDialogState((){


                          estado =
                              valor.toString();


                        });


                      },



                      decoration:

                      const InputDecoration(

                        labelText:"Estado",

                      ),



                    )




                  ],



                ),



              ),





              actions:[




                TextButton(


                  onPressed:(){


                    Navigator.pop(context);


                  },


                  child:

                  const Text(
                      "Cancelar"
                  ),


                ),





                ElevatedButton(


                  onPressed:() async {



                    final dados = {


                      "nome":
                      nomeController.text,


                      "telefone":
                      telefoneController.text,


                      "funcao":
                      funcaoController.text,


                      "estado":
                      estado,


                      "foto":
                      foto,



                    };






                    if(funcionario==null){


                      await DatabaseHelper.instance
                          .criarFuncionario(dados);



                    }else{


                      await DatabaseHelper.instance
                          .atualizarFuncionario(

                        funcionario['id'],

                        dados,

                      );



                    }






                    if(context.mounted){


                      Navigator.pop(context);


                    }



                    carregarFuncionarios();



                  },


                  child:

                  const Text(
                      "Guardar"
                  ),


                )



              ],



            );



          },


        );



      },


    );



  }









  Future<void> eliminarFuncionario(

      int id

      ) async {



    await DatabaseHelper.instance
        .eliminarFuncionario(id);



    carregarFuncionarios();



  }









  @override
  Widget build(BuildContext context){



    return Scaffold(



      appBar:

      AppBar(


        title:

        const Text(

            "Gestão da Equipe"

        ),



      ),







      floatingActionButton:

      FloatingActionButton(



        child:

        const Icon(
            Icons.add
        ),



        onPressed:(){


          abrirFormulario();


        },



      ),







      body:

      funcionarios.isEmpty



          ?

      const Center(

        child:

        Text(

            "Nenhum funcionário cadastrado."

        ),

      )



          :



      ListView.builder(



        itemCount:
        funcionarios.length,



        itemBuilder:
            (context,index){



          final funcionario =
          funcionarios[index];






          return Card(



            margin:

            const EdgeInsets.all(10),



            child:

            ListTile(



              leading:

              CircleAvatar(



                radius:30,



                backgroundImage:

                funcionario['foto'] != null &&
                    funcionario['foto']
                        .toString()
                        .isNotEmpty


                    ?

                FileImage(

                    File(

                        funcionario['foto']

                    )

                )


                    :

                null,




                child:

                funcionario['foto']==null

                    ?

                const Icon(
                    Icons.person
                )

                    :

                null,



              ),





              title:

              Text(

                  funcionario['nome']

              ),





              subtitle:

              Text(

                "${funcionario['funcao']} - ${funcionario['estado']}",

              ),





              trailing:

              PopupMenuButton(



                itemBuilder:(context)=>[



                  const PopupMenuItem(

                    value:"editar",

                    child:

                    Text(
                        "Editar"
                    ),

                  ),



                  const PopupMenuItem(

                    value:"eliminar",

                    child:

                    Text(
                        "Eliminar"
                    ),

                  ),



                ],




                onSelected:(valor){



                  if(valor=="editar"){


                    abrirFormulario(

                      funcionario:
                      funcionario,

                    );


                  }





                  if(valor=="eliminar"){


                    eliminarFuncionario(

                      funcionario['id'],

                    );


                  }




                },



              ),




            ),



          );



        },



      ),



    );



  }



}
