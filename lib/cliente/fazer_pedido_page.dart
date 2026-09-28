
import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';

class FazerPedidoPage extends StatefulWidget {
  final Map<String, dynamic> cliente;
  final String servico;
  final String plano;
  final int valor;

  const FazerPedidoPage({
    super.key,
    required this.cliente,
    required this.servico,
    required this.plano,
    required this.valor,
  });

  @override
  State<FazerPedidoPage> createState() => _FazerPedidoPageState();
}

class _FazerPedidoPageState extends State<FazerPedidoPage> {
  final TextEditingController enderecoController =
      TextEditingController();

  final TextEditingController dataController =
      TextEditingController();

  final TextEditingController horarioController =
      TextEditingController();

  final TextEditingController observacaoController =
      TextEditingController();

  bool carregando = false;

  Future<void> enviarPedido() async {
    if (carregando) {
      return;
    }

    final String endereco = enderecoController.text.trim();
    final String data = dataController.text.trim();
    final String horario = horarioController.text.trim();
    final String observacao = observacaoController.text.trim();

    // Validação dos campos obrigatórios
    if (endereco.isEmpty ||
        data.isEmpty ||
        horario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha todos os campos obrigatórios.',
          ),
        ),
      );
      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      final String nomeCliente =
          (widget.cliente['nome'] ?? '').toString();

      await DatabaseHelper.instance.inserirPedido({
        'cliente': nomeCliente,
        'servico': widget.servico,
        'endereco': endereco,
        'data': data,
        'horario': horario,
        'observacao': observacao,
        'estado': 'Pendente',
      });

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pedido enviado com sucesso.',
          ),
        ),
      );

      Navigator.of(context).pop();
    } catch (e, stackTrace) {
      debugPrint(
        'ERRO AO ENVIAR PEDIDO: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao enviar pedido: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fazer Pedido',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.cleaning_services,
                ),
                title: Text(
                  widget.servico,
                ),
                subtitle: Text(
                  widget.plano,
                ),
                trailing: Text(
                  '${widget.valor} Kz',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: enderecoController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                hintText: 'Introduza o endereço do serviço',
                prefixIcon: Icon(
                  Icons.location_on,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dataController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Data do serviço',
                hintText: 'Ex: 27/07/2026',
                prefixIcon: Icon(
                  Icons.calendar_today,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: horarioController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Horário',
                hintText: 'Ex: 08:00',
                prefixIcon: Icon(
                  Icons.access_time,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: observacaoController,
              maxLines: 3,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                labelText: 'Observação',
                hintText: 'Informações adicionais (opcional)',
                prefixIcon: Icon(
                  Icons.notes,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: carregando
                    ? null
                    : enviarPedido,
                child: carregando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Confirmar Pedido',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    enderecoController.dispose();
    dataController.dispose();
    horarioController.dispose();
    observacaoController.dispose();

    super.dispose();
  }
}
