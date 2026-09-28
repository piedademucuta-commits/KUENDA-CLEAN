
import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';
import '../core/session/session_service.dart';

class SolicitarServicoPage extends StatefulWidget {
  const SolicitarServicoPage({
    super.key,
  });

  @override
  State<SolicitarServicoPage> createState() =>
      _SolicitarServicoPageState();
}

class _SolicitarServicoPageState
    extends State<SolicitarServicoPage> {
  final enderecoController = TextEditingController();
  final observacaoController = TextEditingController();

  String? tipoServico;
  DateTime? dataServico;
  TimeOfDay? horarioServico;

  final List<String> servicos = [
    'Limpeza residencial',
    'Limpeza comercial',
    'Limpeza pÃ³s-obra',
    'Limpeza profunda',
  ];

  Future<void> enviarPedido() async {
    if (tipoServico == null ||
        enderecoController.text.trim().isEmpty ||
        dataServico == null ||
        horarioServico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha todos os campos obrigatÃ³rios',
          ),
        ),
      );
      return;
    }

    final cliente = await SessionService.obterNome();

    if (!mounted) {
      return;
    }

    if (cliente == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'SessÃ£o expirada. FaÃ§a login novamente.',
          ),
        ),
      );
      return;
    }

    final horario = horarioServico!.format(context);

    await DatabaseHelper.instance.inserirPedido({
      'cliente': cliente,
      'servico': tipoServico,
      'endereco': enderecoController.text.trim(),
      'data':
          '${dataServico!.day}/'
          '${dataServico!.month}/'
          '${dataServico!.year}',
      'horario': horario,
      'observacao': observacaoController.text.trim(),
      'estado': 'Pendente',
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pedido enviado com sucesso',
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitar ServiÃ§o',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Novo pedido de limpeza',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              initialValue: tipoServico,
              decoration: const InputDecoration(
                labelText: 'Tipo de serviÃ§o',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.cleaning_services,
                ),
              ),
              items: servicos.map((servico) {
                return DropdownMenuItem<String>(
                  value: servico,
                  child: Text(servico),
                );
              }).toList(),
              onChanged: (valor) {
                setState(() {
                  tipoServico = valor;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: enderecoController,
              decoration: const InputDecoration(
                labelText: 'EndereÃ§o do serviÃ§o',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_on,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              leading: const Icon(
                Icons.calendar_month,
              ),
              title: Text(
                dataServico == null
                    ? 'Escolher data'
                    : '${dataServico!.day}/'
                        '${dataServico!.month}/'
                        '${dataServico!.year}',
              ),
              onTap: () async {
                final data = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                );

                if (!mounted) {
                  return;
                }

                if (data != null) {
                  setState(() {
                    dataServico = data;
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              leading: const Icon(
                Icons.access_time,
              ),
              title: Text(
                horarioServico == null
                    ? 'Escolher horÃ¡rio'
                    : horarioServico!.format(context),
              ),
              onTap: () async {
                final horario = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (!mounted) {
                  return;
                }

                if (horario != null) {
                  setState(() {
                    horarioServico = horario;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: observacaoController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'ObservaÃ§Ãµes',
                hintText: 'Ex: limpar quintal, janelas...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: enviarPedido,
                child: const Text(
                  'Enviar Pedido',
                  style: TextStyle(
                    fontSize: 18,
                  ),
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
    observacaoController.dispose();
    super.dispose();
  }
}


