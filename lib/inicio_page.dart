import 'package:flutter/material.dart';

import 'admin/login_admin_page.dart';
import 'cliente/login_cliente_page.dart';

import 'widgets/area_card.dart';


class InicioPage extends StatelessWidget {

  const InicioPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Kuenda Clean',
        ),

        centerTitle: true,

      ),



      body: Padding(

        padding: const EdgeInsets.all(20),


        child: Column(


          mainAxisAlignment:
              MainAxisAlignment.center,


          children: [



            const Icon(

              Icons.cleaning_services,

              size:90,

              color: Colors.blue,

            ),



            const SizedBox(
              height:20,
            ),




            const Text(

              'Bem-vindo ao Kuenda Clean',

              textAlign:
                  TextAlign.center,


              style: TextStyle(

                fontSize:24,

                fontWeight:
                    FontWeight.bold,

              ),

            ),




            const SizedBox(
              height:10,
            ),




            const Text(

              'Serviços profissionais de limpeza ao seu alcance',

              textAlign:
                  TextAlign.center,


              style: TextStyle(

                fontSize:16,

                color: Colors.grey,

              ),

            ),





            const SizedBox(
              height:40,
            ),





            AreaCard(

              icon: Icons.person,

              titulo: 'Área do Cliente',

              descricao:
              'Solicite serviços e acompanhe seus pedidos',


              onTap: () {


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const LoginClientePage(),

                  ),

                );


              },

            ),





            const SizedBox(
              height:20,
            ),






            AreaCard(

              icon: Icons.admin_panel_settings,

              titulo: 'Área Administrativa',

              descricao:
              'Gestão de clientes, funcionários e pedidos',



              onTap: () {


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const LoginAdminPage(),

                  ),

                );


              },

            ),




          ],

        ),

      ),

    );


  }

}