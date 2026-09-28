import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';



class PedidosAdminPage extends StatefulWidget {


  const PedidosAdminPage({
    super.key,
  });



  @override
  State<PedidosAdminPage> createState() =>
      _PedidosAdminPageState();


}








class _PedidosAdminPageState
    extends State<PedidosAdminPage> {



  List<Map<String, dynamic>> pedidos = [];



  @override
  void initState(){

    super.initState();

    carregarPedidos();

  }








  Future<void> carregarPedidos() async {



    final dados =

    await DatabaseHelper.instance
        .listarPedidos();




    setState(() {


      pedidos = dados;


    });



  }









  Future<void> removerPedido(int id) async {



    await DatabaseHelper.instance
        .removerPedido(id);



    carregarPedidos();



  }









  Future<void> alterarEstado(

      int id,

      String estado,

      ) async {



    await DatabaseHelper.instance
        .atualizarEstadoPedido(

      id,

      estado,

    );



    carregarPedidos();



  }









  @override
  Widget build(BuildContext context){



    return Scaffold(



      appBar: AppBar(


        title:

        const Text(

          'Pedidos de Serviços',

        ),


        centerTitle:true,

      ),







      body:



      pedidos.isEmpty



          ? _listaVazia()



          : RefreshIndicator(



        onRefresh:

        carregarPedidos,



        child:

        ListView.builder(



          padding:

          const EdgeInsets.all(15),



          itemCount:

          pedidos.length,



          itemBuilder:

              (context,index){



            final pedido =
            pedidos[index];




            return Card(



              elevation:4,



              margin:

              const EdgeInsets.only(

                bottom:15,

              ),




              child:

              Padding(



                padding:

                const EdgeInsets.all(15),



                child:

                Column(



                  crossAxisAlignment:

                  CrossAxisAlignment.start,



                  children: [





                    Row(



                      mainAxisAlignment:

                      MainAxisAlignment.spaceBetween,



                      children: [





                        Expanded(

                          child:

                          Text(

                            pedido['cliente'] ?? '',


                            style:

                            const TextStyle(

                              fontSize:18,

                              fontWeight:

                              FontWeight.bold,

                            ),


                          ),

                        ),





                        Chip(

                          label:

                          Text(

                            pedido['estado'] ?? '',

                          ),

                        ),



                      ],


                    ),






                    const SizedBox(height:15),





                    _linha(

                      Icons.cleaning_services,

                      'Serviço',

                      pedido['servico'],

                    ),




                    _linha(

                      Icons.location_on,

                      'Endereço',

                      pedido['endereco'],

                    ),





                    _linha(

                      Icons.calendar_month,

                      'Data',

                      pedido['data'],

                    ),




                    _linha(

                      Icons.access_time,

                      'Horário',

                      pedido['horario'],

                    ),






                    if(pedido['observacao'] != null &&
                        pedido['observacao']
                            .toString()
                            .isNotEmpty)



                      _linha(

                        Icons.note,

                        'Observação',

                        pedido['observacao'],

                      ),







                    const SizedBox(height:15),







                    Row(



                      mainAxisAlignment:

                      MainAxisAlignment.end,



                      children: [





                        TextButton(



                          onPressed: (){

                            alterarEstadoDialog(

                              pedido['id'],

                            );

                          },



                          child:

                          const Text(

                            'Estado',

                          ),


                        ),






                        IconButton(



                          icon:

                          const Icon(

                            Icons.delete,

                          ),



                          onPressed: (){



                            removerPedido(

                              pedido['id'],

                            );



                          },


                        ),



                      ],



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









  Widget _linha(

      IconData icon,

      String titulo,

      dynamic valor,

      ){



    return Padding(



      padding:

      const EdgeInsets.only(

        bottom:8,

      ),



      child:

      Row(



        children: [



          Icon(

            icon,

            size:20,

          ),



          const SizedBox(width:10),





          Text(

            '$titulo: ',

            style:

            const TextStyle(

              fontWeight:

              FontWeight.bold,

            ),

          ),




          Expanded(

            child:

            Text(

              valor?.toString() ?? '',

            ),

          ),



        ],



      ),



    );



  }









  void alterarEstadoDialog(int id){



    showDialog(



      context: context,



      builder:(context){



        return AlertDialog(



          title:

          const Text(

            'Alterar estado',

          ),




          content:

          Column(



            mainAxisSize:

            MainAxisSize.min,



            children: [



              _estadoOpcao(

                id,

                'Pendente',

              ),



              _estadoOpcao(

                id,

                'Aceite',

              ),



              _estadoOpcao(

                id,

                'Em andamento',

              ),



              _estadoOpcao(

                id,

                'Concluído',

              ),



            ],



          ),



        );



      },



    );



  }









  Widget _estadoOpcao(

      int id,

      String estado,

      ){



    return ListTile(



      title:

      Text(estado),



      onTap:(){



        alterarEstado(

          id,

          estado,

        );



        Navigator.pop(context);



      },


    );



  }









  Widget _listaVazia(){



    return const Center(



      child:

      Column(



        mainAxisAlignment:

        MainAxisAlignment.center,



        children: [



          Icon(

            Icons.assignment_outlined,

            size:80,

          ),



          SizedBox(height:20),




          Text(

            'Nenhum pedido encontrado',

          ),



        ],



      ),



    );



  }



}