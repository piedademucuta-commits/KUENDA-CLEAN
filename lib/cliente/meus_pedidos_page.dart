import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';
import '../core/session/session_service.dart';



class MeusPedidosPage extends StatefulWidget {


  const MeusPedidosPage({
    super.key,
  });



  @override
  State<MeusPedidosPage> createState() =>
      _MeusPedidosPageState();


}






class _MeusPedidosPageState
    extends State<MeusPedidosPage> {



  List<Map<String, dynamic>> pedidos = [];

  bool carregando = true;





  @override
  void initState() {

    super.initState();

    carregarPedidos();

  }







  Future<void> carregarPedidos() async {


    final cliente =
        await SessionService.obterNome();



    if(cliente == null){


      setState(() {

        carregando = false;

      });


      return;

    }






    final resultado =

    await DatabaseHelper.instance
        .listarPedidosCliente(cliente);





    setState(() {


      pedidos = resultado;

      carregando = false;


    });


  }









  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar: AppBar(


        title:

        const Text(

          'Meus Pedidos',

        ),


        centerTitle:true,


      ),







      body:


      carregando


          ? const Center(

              child:

              CircularProgressIndicator(),

            )



          :

      RefreshIndicator(


        onRefresh:

        carregarPedidos,



        child:


        pedidos.isEmpty


            ?

        _semPedidos()



            :

        ListView.builder(



          padding:

          const EdgeInsets.all(16),



          itemCount:

          pedidos.length,



          itemBuilder:

              (context,index){



            final pedido = pedidos[index];




            return Card(



              elevation:4,



              margin:

              const EdgeInsets.only(

                bottom:16,

              ),




              child:

              Padding(



                padding:

                const EdgeInsets.all(16),




                child:

                Column(



                  crossAxisAlignment:

                  CrossAxisAlignment.start,



                  children:[




                    Row(


                      mainAxisAlignment:

                      MainAxisAlignment.spaceBetween,


                      children:[



                        Expanded(


                          child:

                          Text(

                            pedido['servico'] ??
                                'Serviço',

                            style:

                            const TextStyle(

                              fontSize:18,

                              fontWeight:
                              FontWeight.bold,

                            ),


                          ),


                        ),





                        _estado(

                          pedido['estado'],

                        ),



                      ],


                    ),






                    const Divider(),






                    _item(

                      Icons.location_on,

                      'Endereço',

                      pedido['endereco'],

                    ),






                    _item(

                      Icons.calendar_month,

                      'Data',

                      pedido['data'],

                    ),






                    _item(

                      Icons.access_time,

                      'Horário',

                      pedido['horario'],

                    ),





                    if(pedido['observacao']
                        .toString()
                        .isNotEmpty)

                      _item(

                        Icons.notes,

                        'Observação',

                        pedido['observacao'],

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










  Widget _estado(String? estado){


    return Chip(

      label:

      Text(

        estado ?? 'Pendente',

      ),

    );


  }









  Widget _item(

      IconData icon,

      String titulo,

      dynamic valor,

      ){



    return Padding(


      padding:

      const EdgeInsets.only(

        bottom:10,

      ),



      child:

      Row(


        children:[



          Icon(

            icon,

            size:20,

          ),




          const SizedBox(

            width:10,

          ),





          Text(

            '$titulo:',

            style:

            const TextStyle(

              fontWeight:
              FontWeight.bold,

            ),

          ),





          const SizedBox(

            width:5,

          ),





          Expanded(

            child:

            Text(

              valor?.toString() ?? '-',

            ),

          ),



        ],


      ),



    );


  }









  Widget _semPedidos(){


    return const Center(


      child:

      Column(


        mainAxisAlignment:

        MainAxisAlignment.center,


        children:[



          Icon(

            Icons.assignment_outlined,

            size:80,

            color:Colors.grey,

          ),



          SizedBox(height:20),




          Text(

            'Nenhum pedido encontrado',

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



}