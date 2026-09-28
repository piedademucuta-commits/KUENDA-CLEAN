
import 'package:flutter/material.dart';

import '../core/database/database_helper.dart';

class CriarAdminPage extends StatefulWidget {
  const CriarAdminPage({
    super.key,
  });

  @override
  State<CriarAdminPage> createState() => _CriarAdminPageState();
}

class _CriarAdminPageState extends State<CriarAdminPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;
  bool carregando = false;

  Future<void> criarConta() async {
    if (carregando) {
      return;
    }

    final String nome = nomeController.text.trim();
    final String email = emailController.text.trim().toLowerCase();
    final String senha = senhaController.text;

    // Validação do nome
    if (nome.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduza o nome do administrador.'),
        ),
      );
      return;
    }

    // Validação do email
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduza o email do administrador.'),
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduza um email válido.'),
        ),
      );
      return;
    }

    // Validação da palavra-passe
    if (senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Introduza a palavra-passe.'),
        ),
      );
      return;
    }

    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A palavra-passe deve ter pelo menos 6 caracteres.',
          ),
        ),
      );
      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      await DatabaseHelper.instance.insertAdmin({
        'nome': nome,
        'email': email,
        'senha': senha,
      });

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Administrador criado com sucesso.',
          ),
        ),
      );

      Navigator.of(context).pop();
    } catch (e, stackTrace) {
      debugPrint(
        'ERRO AO CRIAR ADMINISTRADOR: $e',
      );

      debugPrintStack(
        stackTrace: stackTrace,
      );

      if (!mounted) {
        return;
      }

      final String erro = e.toString().toLowerCase();

      if (erro.contains('unique') ||
          erro.contains('constraint') ||
          erro.contains('email')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Este email já está registado.',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao criar administrador: $e',
            ),
          ),
        );
      }
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
          'Criar Administrador',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Icon(
                Icons.admin_panel_settings,
                size: 90,
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nomeController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Nome completo',
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'admin@exemplo.com',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: senhaController,
                obscureText: esconderSenha,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                enableSuggestions: false,
                onSubmitted: (_) {
                  criarConta();
                },
                decoration: InputDecoration(
                  labelText: 'Palavra-passe',
                  hintText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(
                    Icons.lock,
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    tooltip: esconderSenha
                        ? 'Mostrar palavra-passe'
                        : 'Ocultar palavra-passe',
                    icon: Icon(
                      esconderSenha
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        esconderSenha = !esconderSenha;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: carregando ? null : criarConta,
                  child: carregando
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Criar Administrador',
                        ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();

    super.dispose();
  }
}

