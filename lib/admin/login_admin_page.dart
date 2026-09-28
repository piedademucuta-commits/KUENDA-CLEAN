import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';
import '../core/session/session_service.dart';

import 'dashboard_admin_page.dart';



class LoginAdminPage extends StatefulWidget {


  const LoginAdminPage({
    super.key,
  });



  @override
  State<LoginAdminPage> createState() =>
      _LoginAdminPageState();

}





class _LoginAdminPageState extends State<LoginAdminPage> {


  final emailController =
      TextEditingController();


  final senhaController =
      TextEditingController();


  bool esconderSenha = true;



  Future<void> entrar() async {


    final email =
        emailController.text.trim();


    final senha =
        senhaController.text.trim();



    if(email.isEmpty || senha.isEmpty){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Preencha todos os campos',
          ),
        ),

      );

      return;
    }



    final admin =
    await DatabaseHelper.instance.loginAdmin(
      email,
      senha,
    );



    if(admin == null){

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Email ou senha incorretos',
          ),
        ),

      );

      return;
    }



    await SessionService.salvarSessao(

      nome: admin['nome'],

      email: admin['email'],

      tipo: 'admin',

    );



    if(!mounted) return;



    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) => AdminHomePage(

          admin: admin,

        ),

      ),

    );


  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          'Login Administrador',
        ),

      ),



      body: Padding(

        padding: const EdgeInsets.all(25),


        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,


          children: [



            const Icon(

              Icons.admin_panel_settings,

              size:90,

            ),



            const SizedBox(height:30),



            TextField(

              controller:
              emailController,

              decoration:
              const InputDecoration(

                labelText:'Email',

                prefixIcon:
                Icon(Icons.email),

              ),

            ),



            const SizedBox(height:20),



            TextField(

              controller:
              senhaController,

              obscureText:
              esconderSenha,


              decoration:
              InputDecoration(

                labelText:'Senha',

                prefixIcon:
                const Icon(Icons.lock),


                suffixIcon:
                IconButton(

                  icon: Icon(

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

              ),

            ),



            const SizedBox(height:30),



            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton(

                onPressed:
                entrar,


                child:
                const Text(
                  'Entrar',
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

    emailController.dispose();

    senhaController.dispose();

    super.dispose();

  }


}
