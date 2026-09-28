import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/database/database_helper.dart';



class PerfilAdminPage extends StatefulWidget {


  final Map<String,dynamic> admin;


  const PerfilAdminPage({

    super.key,

    required this.admin,

  });



  @override
  State<PerfilAdminPage> createState() =>
      _PerfilAdminPageState();


}






class _PerfilAdminPageState extends State<PerfilAdminPage> {



  final ImagePicker picker = ImagePicker();



  late TextEditingController nomeController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;
  late TextEditingController senhaController;



  String? foto;



  bool carregando = false;






  @override
  void initState(){


    super.initState();


    foto = widget.admin['foto'];



    nomeController =
        TextEditingController(
          text: widget.admin['nome'] ?? '',
        );



    telefoneController =
        TextEditingController(
          text: widget.admin['telefone'] ?? '',
        );



    emailController =
        TextEditingController(
          text: widget.admin['email'] ?? '',
        );



    senhaController =
        TextEditingController(
          text: widget.admin['senha'] ?? '',
        );


  }








  @override
  void dispose(){


    nomeController.dispose();

    telefoneController.dispose();

    emailController.dispose();

    senhaController.dispose();


    super.dispose();


  }









  Future<void> escolherFoto() async {



    final XFile? imagem =
    await picker.pickImage(

      source: ImageSource.gallery,

      imageQuality: 80,

    );



    if(imagem != null){


      setState((){


        foto = imagem.path;


      });


    }



  }









  Future<void> removerFoto() async {


    setState((){


      foto = null;


    });


  }









  Future<void> salvar() async {



    setState((){


      carregando = true;


    });





    await DatabaseHelper.instance
        .atualizarAdministrador(

      widget.admin['id'],

      {


        "nome":
        nomeController.text.trim(),



        "telefone":
        telefoneController.text.trim(),



        "email":
        emailController.text.trim(),



        "senha":
        senhaController.text.trim(),



        "foto":
        foto,


      },


    );






    if(!mounted)return;



    setState((){


      carregando = false;


    });





    Navigator.pop(

      context,

      {


        "foto":foto,


        "nome":
        nomeController.text.trim(),


        "telefone":
        telefoneController.text.trim(),


        "email":
        emailController.text.trim(),


      },


    );



  }









  Widget campo(

      String titulo,

      TextEditingController controller,

      IconData icon,

      ){

    return Padding(


      padding:
      const EdgeInsets.only(bottom:15),



      child: TextField(


        controller: controller,


        decoration: InputDecoration(


          labelText: titulo,


          prefixIcon:
          Icon(icon),



          border:
          const OutlineInputBorder(),


        ),



      ),


    );


  }









  @override
  Widget build(BuildContext context) {



    return Scaffold(



      appBar: AppBar(



        title:
        const Text(

          "Perfil do Administrador",

        ),



      ),






      body: SingleChildScrollView(



        padding:
        const EdgeInsets.all(20),




        child: Column(



          children: [







            GestureDetector(



              onTap: escolherFoto,



              child: Stack(



                children: [



                  CircleAvatar(



                    radius:65,



                    backgroundImage:

                    foto != null &&
                    foto!.isNotEmpty


                        ? FileImage(

                      File(foto!),

                    )

                        : null,



                    child:

                    foto == null ||
                    foto!.isEmpty


                        ? const Icon(

                      Icons.person,

                      size:60,

                    )


                        : null,



                  ),





                  Positioned(



                    bottom:0,


                    right:0,



                    child: Container(



                      padding:
                      const EdgeInsets.all(8),



                      decoration:
                      const BoxDecoration(


                        color:Colors.blue,

                        shape:
                        BoxShape.circle,


                      ),



                      child:
                      const Icon(



                        Icons.camera_alt,


                        color:Colors.white,


                      ),



                    ),



                  ),




                ],



              ),



            ),







            const SizedBox(height:10),






            TextButton(



              onPressed: removerFoto,



              child:
              const Text(

                "Remover foto",

              ),



            ),







            const SizedBox(height:20),






            campo(

              "Nome",

              nomeController,

              Icons.person,

            ),





            campo(

              "Telefone",

              telefoneController,

              Icons.phone,

            ),






            campo(

              "Email",

              emailController,

              Icons.email,

            ),







            campo(

              "Palavra-passe",

              senhaController,

              Icons.lock,

            ),







            const SizedBox(height:20),







            SizedBox(



              width:double.infinity,



              height:50,



              child:
              ElevatedButton(



                onPressed:

                carregando

                    ? null

                    : salvar,




                child:


                carregando


                    ?

                const CircularProgressIndicator()



                    :

                const Text(

                  "Guardar alterações",

                ),




              ),



            ),







          ],



        ),



      ),




    );



  }


}