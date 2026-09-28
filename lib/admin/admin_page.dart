
import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';

class ClientesAdminPage extends StatefulWidget {
  const ClientesAdminPage({
    super.key,
  });

  @override
  State<ClientesAdminPage> createState() => _ClientesAdminPageState();
}

class _ClientesAdminPageState extends State<ClientesAdminPage> {
  List<Map<String, dynamic>> clientes = [];

  @override
  void initState() {
    super.initState();
    carregarClientes();
  }

  Future<void> carregarClientes() async {
    final dados = await DatabaseHelper.instance.listarClientes();

    if (!mounted) {
      return;
    }

    setState(() {
      clientes = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clientes',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: novoCliente,
        child: const Icon(
          Icons.person_add,
        ),
      ),
      body: clientes.isEmpty
          ? const Center(
              child: Text(
                'Nenhum cliente cadastrado',
              ),
            )
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];

                final String nome =
                    (cliente['nome'] ?? '').toString();

                final String telefone =
                    (cliente['telefone'] ?? '').toString();

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        nome.isNotEmpty
                            ? nome.substring(0, 1).toUpperCase()
                            : '?',
                      ),
                    ),
                    title: Text(
                      nome,
                    ),
                    subtitle: Text(
                      telefone,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () async {
                        await DatabaseHelper.instance.removerCliente(
                          cliente['id'],
                        );

                        await carregarClientes();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void novoCliente() {
    final nome = TextEditingController();
    final telefone = TextEditingController();
    final email = TextEditingController();
    final endereco = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Novo Cliente',
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                campo(
                  nome,
                  'Nome',
                ),
                campo(
                  telefone,
                  'Telefone',
                ),
                campo(
                  email,
                  'Email',
                ),
                campo(
                  endereco,
                  'Endereço',
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.inserirCliente({
                  'nome': nome.text.trim(),
                  'telefone': telefone.text.trim(),
                  'email': email.text.trim(),
                  'endereco': endereco.text.trim(),
                });

                if (!dialogContext.mounted) {
                  return;
                }

                Navigator.of(dialogContext).pop();

                await carregarClientes();

                nome.dispose();
                telefone.dispose();
                email.dispose();
                endereco.dispose();
              },
              child: const Text(
                'Salvar',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget campo(
    TextEditingController controller,
    String texto,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: texto,
      ),
    );
  }
}

