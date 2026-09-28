
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estado dos Pedidos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 45,
                  sections: [
                    PieChartSectionData(
                      value: pendentes.toDouble(),
                      title: 'Pendentes\n$pendentes',
                      radius: 70,
                      color: Colors.orange,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: andamento.toDouble(),
                      title: 'Andamento\n$andamento',
                      radius: 70,
                      color: Colors.blue,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: concluidos.toDouble(),
                      title: 'Concluídos\n$concluidos',
                      radius: 70,
                      color: Colors.green,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _legenda(
                  'Pendentes',
                  Colors.orange,
                ),
                _legenda(
                  'Andamento',
                  Colors.blue,
                ),
                _legenda(
                  'Concluídos',
                  Colors.green,
                ),
              ],
            ),
          ],
        ),
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(texto),
      ],
    );
  }
}

