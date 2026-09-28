
import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';
import '../core/session/session_service.dart';

import 'solicitar_servico_page.dart';
import 'meus_pedidos_page.dart';
import 'perfil_cliente_page.dart';

class ClienteHomePage extends StatefulWidget {
  const ClienteHomePage({
    super.key,
  });

  @override
  State<ClienteHomePage> createState() => _ClienteHomePageState();
}

class _ClienteHomePageState extends State<ClienteHomePage> {
  String nomeCliente = 'Cliente';
  Map<String, dynamic>? clienteAtual;

  @override
  void initState() {
    super.initState();
    carregarCliente();
  }

  Future<void> carregarCliente() async {
    final email = await SessionService.obterEmail();

    if (email == null || email.trim().isEmpty) {
      return;
    }

    final cliente =
        await DatabaseHelper.instance.obterClientePorEmail(email);

    if (!mounted) {
      return;
    }

    if (cliente != null) {
      setState(() {
        clienteAtual = cliente;
        nomeCliente = cliente['nome']?.toString() ?? 'Cliente';
      });
    }
  }

  Future<void> abrirPerfil() async {
    if (clienteAtual == null) {
      await carregarCliente();
    }

    if (!mounted) {
      return;
    }

    if (clienteAtual == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível carregar os dados do cliente.',
          ),
        ),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PerfilClientePage(
          cliente: clienteAtual!,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    await carregarCliente();
  }

  Future<void> sair() async {
    await SessionService.limparSessao();

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text(
              'Sessão encerrada',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Área do Cliente',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Meu Perfil',
            icon: const Icon(
              Icons.person,
            ),
            onPressed: abrirPerfil,
          ),
          IconButton(
            tooltip: 'Terminar sessão',
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: sair,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, $nomeCliente',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Solicite serviços de limpeza profissional',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.cleaning_services,
                  size: 40,
                ),
                title: const Text(
                  'Solicitar Serviço',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Agende uma limpeza',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SolicitarServicoPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.assignment,
                  size: 40,
                ),
                title: const Text(
                  'Meus Pedidos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Acompanhe seus serviços',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MeusPedidosPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  size: 40,
                ),
                title: const Text(
                  'Meu Perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  nomeCliente,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
                onTap: abrirPerfil,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
