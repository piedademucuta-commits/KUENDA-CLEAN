import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';


class HistoricoPedidosPage extends StatefulWidget {


  final Map<String, dynamic> cliente;



  const HistoricoPedidosPage({

    super.key,

    required this.cliente,

  });



  @override
  State<HistoricoPedidosPage> createState() =>
      _HistoricoPedidosPageState();


}




class _HistoricoPedidosPageState extends State<HistoricoPedidosPage> {



  List<Map<String, dynamic>> pedidos = [];

  bool carregando = true;



  @override
  void initState() {

    super.initState();

    carregarPedidos();

  }






  Future<void> carregarPedidos() async {


    final todosPedidos =
        await DatabaseHelper.instance.listarPedidos();



    final pedidosCliente =
        todosPedidos.where((pedido) {


      return pedido["cliente_id"] ==
          widget.cliente["id"];


    }).toList();



    if (!mounted) return;



    setState(() {


      pedidos = pedidosCliente;

      carregando = false;


    });


  }








  Color corEstado(String estado) {


    switch (estado) {


      case "Pendente":

        return Colors.orange;



      case "Aceite":

        return Colors.blue;



      case "Concluído":

        return Colors.green;



      case "Cancelado":

        return Colors.red;



      default:

        return Colors.grey;

    }


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(

          "Histórico de Pedidos",

        ),


      ),





      body: RefreshIndicator(


        onRefresh: carregarPedidos,



        child: carregando


            ? const Center(

                child: CircularProgressIndicator(),

              )



            : pedidos.isEmpty



                ? ListView(

                    children: const [


                      SizedBox(height: 200),


                      Center(

                        child: Text(

                          "Ainda não existem pedidos.",


                          style: TextStyle(

                            fontSize: 18,

                          ),

                        ),

                      ),

                    ],


                  )




                : ListView.builder(


                    padding: const EdgeInsets.all(15),



                    itemCount: pedidos.length,



                    itemBuilder: (context, index) {



                      final pedido = pedidos[index];



                      return Card(


                        elevation: 3,



                        margin: const EdgeInsets.only(

                          bottom: 15,

                        ),



                        child: Padding(


                          padding: const EdgeInsets.all(15),



                          child: Column(


                            crossAxisAlignment:
                                CrossAxisAlignment.start,



                            children: [



                              Row(

                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,


                                children: [



                                  Expanded(

                                    child: Text(


                                      pedido["servico"],


                                      style: const TextStyle(


                                        fontSize: 18,


                                        fontWeight:
                                            FontWeight.bold,


                                      ),


                                    ),

                                  ),



                                  Container(

                                    padding:
                                        const EdgeInsets.symmetric(

                                      horizontal: 10,

                                      vertical: 5,

                                    ),



                                    decoration: BoxDecoration(


                                      color: corEstado(
                                          pedido["estado"])
                                          .withValues(alpha: 0.15),



                                      borderRadius:
                                          BorderRadius.circular(20),


                                    ),



                                    child: Text(


                                      pedido["estado"],



                                      style: TextStyle(


                                        color: corEstado(
                                            pedido["estado"]),


                                        fontWeight:
                                            FontWeight.bold,


                                      ),


                                    ),

                                  ),


                                ],

                              ),





                              const Divider(),




                              Text(

                                "Plano: ${pedido["plano"]}",

                              ),



                              const SizedBox(height: 8),




                              Text(

                                "Valor: ${pedido["valor"]} Kz",

                                style: const TextStyle(

                                  fontWeight: FontWeight.bold,

                                ),

                              ),





                              const SizedBox(height: 8),




                              Text(

                                "Local: ${pedido["local"]}",

                              ),





                              const SizedBox(height: 8),




                              Text(

                                "Data: ${pedido["data"]}",

                              ),



                            ],


                          ),


                        ),


                      );


                    },


                  ),


      ),


    );


  }



}
