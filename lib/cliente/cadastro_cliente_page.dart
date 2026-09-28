import 'package:flutter/material.dart';
import '../core/database/database_helper.dart';



class CadastroClientePage extends StatefulWidget {


  const CadastroClientePage({
    super.key,
  });



  @override
  State<CadastroClientePage> createState() =>
      _CadastroClientePageState();


}







class _CadastroClientePageState
    extends State<CadastroClientePage> {



  final nomeController =
      TextEditingController();



  final telefoneController =
      TextEditingController();



  final emailController =
      TextEditingController();



  final enderecoController =
      TextEditingController();



  final senhaController =
      TextEditingController();




  bool esconderSenha = true;








  Future<void> cadastrar() async {



    final nome =
        nomeController.text.trim();



    final telefone =
        telefoneController.text.trim();



    final email =
        emailController.text.trim();



    final endereco =
        enderecoController.text.trim();



    final senha =
        senhaController.text.trim();







    if(nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty){



      ScaffoldMessenger.of(context)
          .showSnackBar(



        const SnackBar(



          content:

          Text(

            'Preencha nome, email e senha',

          ),



        ),



      );



      return;


    }







    try{



      await DatabaseHelper.instance
          .inserirCliente(



        {


          'nome':

          nome,



          'telefone':

          telefone,



          'email':

          email,



          'endereco':

          endereco,



          'senha':

          senha,



        },



      );







      if(!mounted) return;








      ScaffoldMessenger.of(context)
          .showSnackBar(



        const SnackBar(



          content:

          Text(

            'Cadastro realizado com sucesso',

          ),



        ),



      );








      Navigator.pop(context);




       } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro no cadastro: $e',
          ),
        ),
      );

     
      debugPrint('ERRO REAL NO CADASTRO: $e');
    }
  }

  @override
  Widget build(BuildContext context) {



  



    return Scaffold(



      appBar:

      AppBar(



        title:

        const Text(

          'Cadastro Cliente',

        ),



        centerTitle:

        true,



      ),







      body:

      SingleChildScrollView(



        padding:

        const EdgeInsets.all(25),




        child:

        Column(



          children:[





            const Icon(



              Icons.person_add,



              size:

              80,



            ),






            const SizedBox(height:25),







            TextField(



              controller:

              nomeController,



              decoration:

              const InputDecoration(



                labelText:

                'Nome completo',



                prefixIcon:

                Icon(Icons.person),



                border:

                OutlineInputBorder(),



              ),



            ),







            const SizedBox(height:15),







            TextField(



              controller:

              telefoneController,



              keyboardType:

              TextInputType.phone,



              decoration:

              const InputDecoration(



                labelText:

                'Telefone',



                prefixIcon:

                Icon(Icons.phone),



                border:

                OutlineInputBorder(),



              ),



            ),







            const SizedBox(height:15),







            TextField(



              controller:

              emailController,



              keyboardType:

              TextInputType.emailAddress,



              decoration:

              const InputDecoration(



                labelText:

                'Email',



                prefixIcon:

                Icon(Icons.email),



                border:

                OutlineInputBorder(),



              ),



            ),







            const SizedBox(height:15),







            TextField(



              controller:

              enderecoController,



              decoration:

              const InputDecoration(



                labelText:

                'Endereço',



                prefixIcon:

                Icon(Icons.location_on),



                border:

                OutlineInputBorder(),



              ),



            ),







            const SizedBox(height:15),







            TextField(



              controller:

              senhaController,



              obscureText:

              esconderSenha,



              decoration:

              InputDecoration(



                labelText:

                'Senha',



                prefixIcon:

                const Icon(Icons.lock),




                suffixIcon:

                IconButton(



                  icon:

                  Icon(



                    esconderSenha

                    ? Icons.visibility

                    : Icons.visibility_off,



                  ),



                  onPressed:(){



                    setState(() {



                      esconderSenha =
                      !esconderSenha;



                    });



                  },



                ),



                border:

                const OutlineInputBorder(),



              ),



            ),







            const SizedBox(height:30),







            SizedBox(



              width:

              double.infinity,



              height:

              55,



              child:

              ElevatedButton(



                onPressed:

                cadastrar,



                child:

                const Text(



                  'Cadastrar',



                  style:

                  TextStyle(

                    fontSize:18,

                  ),



                ),



              ),



            ),




          ],



        ),



      ),



    );

  }









  @override
  void dispose(){



    nomeController.dispose();


    telefoneController.dispose();


    emailController.dispose();


    enderecoController.dispose();


    senhaController.dispose();



    super.dispose();


  }



}