import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';
import 'perfil_admin_page.dart';



class AdminHomePage extends StatefulWidget {


  final Map<String,dynamic> admin;


  const AdminHomePage({

    super.key,

    required this.admin,

  });



  @override
  State<AdminHomePage> createState() =>
      _AdminHomePageState();


}






class _AdminHomePageState extends State<AdminHomePage>{



  int clientes = 0;
  int pedidos = 0;
  int funcionarios = 0;
  int pendentes = 0;




  @override
  void initState(){

    super.initState();

    carregarDados();

  }







  Future<void> carregarDados() async {


    final db =
    DatabaseHelper.instance;



    final totalClientes =
    await db.contarClientes();



    final totalPedidos =
    await db.contarPedidos();



    final totalFuncionarios =
    await db.contarFuncionarios();



    final totalPendentes =
    await db.contarPedidosPendentes();




    setState(() {


      clientes = totalClientes;

      pedidos = totalPedidos;

      funcionarios = totalFuncionarios;

      pendentes = totalPendentes;


    });



  }









  Widget cardEstatistica(

      String titulo,

      int valor,

      IconData icone,

      Color cor,

      ){



    return Card(


      elevation:4,


      child: Container(

        padding:
        const EdgeInsets.all(20),


        child: Column(


          mainAxisAlignment:
          MainAxisAlignment.center,


          children:[



            Icon(

              icone,

              size:40,

              color:cor,

            ),




            const SizedBox(
              height:10,
            ),





            Text(

              valor.toString(),

              style:
              const TextStyle(

                fontSize:28,

                fontWeight:
                FontWeight.bold,

              ),

            ),




            const SizedBox(
              height:5,
            ),





            Text(

              titulo,

              textAlign:
              TextAlign.center,

            )




          ],


        ),


      ),


    );


  }









  @override
  Widget build(BuildContext context){



    return Scaffold(




      appBar: AppBar(


        title:
        const Text(
            "Painel Administrador"
        ),




        actions:[



          IconButton(


            icon:
            const Icon(
                Icons.account_circle
            ),



            onPressed:(){



              Navigator.push(

                context,

                MaterialPageRoute(

                  builder:(_)=>

                  PerfilAdminPage(

                    admin:
                    widget.admin,

                  ),

                ),

              );



            },


          )


        ],



      ),






      body:
      RefreshIndicator(



        onRefresh:
        carregarDados,



        child:
        SingleChildScrollView(


          physics:
          const AlwaysScrollableScrollPhysics(),



          padding:
          const EdgeInsets.all(15),



          child:
          Column(



            crossAxisAlignment:
            CrossAxisAlignment.start,



            children:[





              Text(

                "Bem-vindo, ${widget.admin['nome']}",


                style:
                const TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.bold,

                ),


              ),






              const SizedBox(
                  height:20
              ),







              GridView.count(



                crossAxisCount:
                2,



                shrinkWrap:true,



                physics:
                const NeverScrollableScrollPhysics(),



                children:[



                  cardEstatistica(

                    "Clientes",

                    clientes,

                    Icons.people,

                    Colors.blue,

                  ),





                  cardEstatistica(

                    "Pedidos",

                    pedidos,

                    Icons.assignment,

                    Colors.green,

                  ),





                  cardEstatistica(

                    "Funcionários",

                    funcionarios,

                    Icons.badge,

                    Colors.orange,

                  ),






                  cardEstatistica(

                    "Pendentes",

                    pendentes,

                    Icons.pending_actions,

                    Colors.red,

                  ),




                ],



              ),






              const SizedBox(
                  height:30
              ),






              const Text(


                "Gestão do Sistema",


                style:
                TextStyle(

                  fontSize:20,

                  fontWeight:
                  FontWeight.bold,

                ),


              ),








              const SizedBox(
                  height:15
              ),






              Card(


                child:
                ListTile(


                  leading:
                  const Icon(

                    Icons.shopping_cart,

                    color:Colors.green,

                  ),




                  title:
                  const Text(
                      "Gerir pedidos"
                  ),



                  subtitle:
                  const Text(
                      "Ver, aceitar e atualizar pedidos"
                  ),



                  trailing:
                  const Icon(
                      Icons.arrow_forward_ios
                  ),




                  onTap:(){


                    // Próxima etapa:
                    // pagina de gestão de pedidos



                  },


                ),



              ),







              Card(


                child:
                ListTile(


                  leading:
                  const Icon(

                    Icons.people,

                    color:Colors.blue,

                  ),



                  title:
                  const Text(
                      "Gerir clientes"
                  ),



                  subtitle:
                  const Text(
                      "Consultar clientes cadastrados"
                  ),




                  trailing:
                  const Icon(
                      Icons.arrow_forward_ios
                  ),



                  onTap:(){



                  },



                ),



              ),








              Card(


                child:
                ListTile(


                  leading:
                  const Icon(

                    Icons.person_add,

                    color:Colors.orange,

                  ),



                  title:
                  const Text(
                      "Gerir funcionários"
                  ),



                  subtitle:
                  const Text(
                      "Adicionar e controlar funcionários"
                  ),



                  trailing:
                  const Icon(
                      Icons.arrow_forward_ios
                  ),



                  onTap:(){



                  },


                ),



              ),







            ],



          ),



        ),


      ),



    );



  }



}