import 'package:flutter/material.dart';

import '../cliente/login_cliente_page.dart';
import '../admin/login_admin_page.dart';



class WelcomePage extends StatelessWidget {


  const WelcomePage({
    super.key,
  });




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body:


      SafeArea(


        child:


        Padding(


          padding:

          const EdgeInsets.all(25),



          child:


          Column(



            mainAxisAlignment:

            MainAxisAlignment.center,



            children: [




              Icon(


                Icons.cleaning_services,


                size:

                100,



                color:

                Theme.of(context)
                    .colorScheme
                    .primary,


              ),





              const SizedBox(height:25),





              const Text(


                'Kuenda Clean',



                style:

                TextStyle(



                  fontSize:34,



                  fontWeight:

                  FontWeight.bold,



                ),



              ),





              const SizedBox(height:10),





              const Text(


                'Serviços de limpeza profissional',



                textAlign:

                TextAlign.center,



                style:

                TextStyle(



                  fontSize:16,



                  color:

                  Colors.grey,



                ),



              ),





              const SizedBox(height:50),





              _botaoAcesso(



                context,



                icon:

                Icons.person,



                titulo:

                'Área do Cliente',



                pagina:

                const LoginClientePage(),



              ),






              const SizedBox(height:20),






              _botaoAcesso(



                context,



                icon:

                Icons.admin_panel_settings,



                titulo:

                'Administrador',



                pagina:

                const LoginAdminPage(),



              ),





            ],



          ),



        ),



      ),



    );

  }









  Widget _botaoAcesso(



      BuildContext context,



      {


      required IconData icon,


      required String titulo,


      required Widget pagina,


      }

      ) {



    return SizedBox(



      width:

      double.infinity,



      height:

      55,



      child:


      ElevatedButton.icon(



        icon:

        Icon(icon),




        label:


        Text(



          titulo,



          style:


          const TextStyle(



            fontSize:18,



          ),



        ),




        onPressed: () {



          Navigator.push(



            context,



            MaterialPageRoute(



              builder: (_) => pagina,



            ),



          );



        },



      ),



    );

  }



}