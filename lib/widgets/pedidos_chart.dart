import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class PedidosChart extends StatelessWidget {


  final int pendentes;

  final int andamento;

  final int concluidos;



  const PedidosChart({

    super.key,

    required this.pendentes,

    required this.andamento,

    required this.concluidos,

  });



  @override
  Widget build(BuildContext context) {


    final total =
        pendentes + andamento + concluidos;



    return Card(

      elevation: 4,


      shape: RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(18),

      ),



      child: Padding(

        padding:
        const EdgeInsets.all(20),



        child: Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [



            const Text(

              "Estado dos Pedidos",

              style: TextStyle(

                fontSize: 18,

                fontWeight:
                FontWeight.bold,

              ),

            ),



            const SizedBox(height: 20),





            SizedBox(

              height: 230,


              child: total == 0

                  ? const Center(

                      child: Text(

                        "Sem pedidos registados",

                        style: TextStyle(

                          color: Colors.grey,

                        ),

                      ),

                    )


                  : PieChart(

                      PieChartData(

                        sectionsSpace: 3,

                        centerSpaceRadius: 45,


                        sections: [


                          _criarSecao(

                            titulo: "Pendentes",

                            valor: pendentes,

                            cor: Colors.orange,

                          ),



                          _criarSecao(

                            titulo: "Andamento",

                            valor: andamento,

                            cor: Colors.blue,

                          ),



                          _criarSecao(

                            titulo: "Concluídos",

                            valor: concluidos,

                            cor: Colors.green,

                          ),


                        ],


                      ),


                    ),

            ),





            const SizedBox(height: 20),





            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceAround,


              children: [


                _legenda(

                  "Pendentes",

                  Colors.orange,

                ),



                _legenda(

                  "Andamento",

                  Colors.blue,

                ),



                _legenda(

                  "Concluídos",

                  Colors.green,

                ),



              ],

            ),



          ],

        ),

      ),

    );

  }







  PieChartSectionData _criarSecao({

    required String titulo,

    required int valor,

    required Color cor,

  }) {


    return PieChartSectionData(

      value:
      valor.toDouble(),


      title:
      "$titulo\n$valor",


      radius:70,


      color:cor,


      titleStyle:
      const TextStyle(

        fontSize:12,

        fontWeight:
        FontWeight.bold,

        color:
        Colors.white,

      ),

    );

  }








  Widget _legenda(

      String texto,

      Color cor,

      ) {


    return Row(

      children: [


        Container(

          width:12,

          height:12,


          decoration:
          BoxDecoration(

            color:cor,

            shape:
            BoxShape.circle,

          ),

        ),



        const SizedBox(width:6),



        Text(

          texto,

          style:
          const TextStyle(

            fontSize:13,

          ),

        ),



      ],

    );

  }


}