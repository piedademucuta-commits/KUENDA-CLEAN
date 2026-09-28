import 'package:flutter/material.dart';
import 'fazer_pedido_page.dart';

class ServicosPage extends StatelessWidget {
  final Map<String, dynamic> cliente;

  const ServicosPage({
    super.key,
    required this.cliente,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kuenda Clean - Serviços"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [

          const Text(
            "PLANO A - Lavagem de Sofá",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Sofá de 2 lugares","Plano A",10000),
          servico(context,"Sofá de 3 lugares","Plano A",11000),
          servico(context,"Sofá de 4 lugares","Plano A",12000),
          servico(context,"Sofá de 5 lugares","Plano A",13000),
          servico(context,"Sofá de 6 lugares","Plano A",14000),
          servico(context,"Sofá de 7 lugares","Plano A",15000),
          servico(context,"Sofá de 8 lugares","Plano A",16000),

          const SizedBox(height:20),

          const Text(
            "PLANO B - Lavagem de Colchão",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Colchão Solteiro","Plano B",10000),
          servico(context,"Colchão Casal","Plano B",12000),
          servico(context,"Colchão King Size","Plano B",14000),

          const SizedBox(height:20),

          const Text(
            "PLANO C - Lavagem de Cadeiras",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Cadeira","Plano C",2500),
          servico(context,"Poltrona","Plano C",4000),

          const SizedBox(height:20),

          const Text(
            "PLANO D - Lavagem de Cortinas",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Jogo Pequeno","Plano D",10000),
          servico(context,"Jogo Médio","Plano D",12000),
          servico(context,"Jogo Grande","Plano D",14000),

          const SizedBox(height:20),

          const Text(
            "PLANO E - Lavagem de Carros",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Carro Turismo","Plano E",15000),
          servico(context,"Carro 4x4","Plano E",20000),

          const SizedBox(height:20),

          const Text(
            "PLANO E - Lavagem de Tapetes",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),

          servico(context,"Tapete Pequeno","Plano E",5000),
          servico(context,"Tapete Médio","Plano E",8000),
          servico(context,"Tapete Grande","Plano E",13000),

          const SizedBox(height:30),
        ],
      ),
    );
  }

  Widget servico(
      BuildContext context,
      String nome,
      String plano,
      int valor,
      ) {

    return Card(
      child: ListTile(
        leading: const Icon(Icons.cleaning_services),
        title: Text(nome),
        subtitle: Text(plano),
        trailing: Text(
          "$valor Kz",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FazerPedidoPage(
                cliente: cliente,
                servico: nome,
                plano: plano,
                valor: valor,
              ),
            ),
          );
        },
      ),
    );
  }
}