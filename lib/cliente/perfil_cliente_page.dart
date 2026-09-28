
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/database/database_helper.dart';
import 'login_cliente_page.dart';

class PerfilClientePage extends StatefulWidget {
  final Map<String, dynamic> cliente;

  const PerfilClientePage({
    super.key,
    required this.cliente,
  });

  @override
  State<PerfilClientePage> createState() => _PerfilClientePageState();
}

class _PerfilClientePageState extends State<PerfilClientePage> {
  String? fotoAtual;

  final _senhaAtualController = TextEditingController();
  final _novaSenhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool mostrarSenhaAtual = false;
  bool mostrarNovaSenha = false;
  bool mostrarConfirmarSenha = false;
  bool alterandoSenha = false;

  @override
  void initState() {
    super.initState();
    fotoAtual = widget.cliente['foto'];
  }

  @override
  void dispose() {
    _senhaAtualController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  Future<void> escolherFoto() async {
    final picker = ImagePicker();

    final imagem = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (imagem == null) {
      return;
    }

    await DatabaseHelper.instance.atualizarFotoCliente(
      widget.cliente['id'],
      imagem.path,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      fotoAtual = imagem.path;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Foto atualizada com sucesso.'),
      ),
    );
  }

  void visualizarFoto() {
    if (fotoAtual == null || fotoAtual!.isEmpty) {
      escolherFoto();
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.file(
                    File(fotoAtual!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Alterar foto'),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    escolherFoto();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> alterarSenha() async {
    final senhaAtual = _senhaAtualController.text.trim();
    final novaSenha = _novaSenhaController.text.trim();
    final confirmarSenha = _confirmarSenhaController.text.trim();

    if (senhaAtual.isEmpty ||
        novaSenha.isEmpty ||
        confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos da senha.'),
        ),
      );
      return;
    }

    if (novaSenha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A nova senha deve ter pelo menos 6 caracteres.',
          ),
        ),
      );
      return;
    }

    if (novaSenha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A confirmação da nova senha não coincide.',
          ),
        ),
      );
      return;
    }

    if (senhaAtual == novaSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A nova senha deve ser diferente da senha atual.',
          ),
        ),
      );
      return;
    }

    setState(() {
      alterandoSenha = true;
    });

    try {
      final clienteAtualizado =
          await DatabaseHelper.instance.obterClientePorEmail(
        widget.cliente['email'].toString(),
      );

      if (!mounted) {
        return;
      }

      if (clienteAtualizado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente não encontrado.'),
          ),
        );
        return;
      }

      final senhaGuardada =
          clienteAtualizado['senha']?.toString() ?? '';

      if (senhaGuardada != senhaAtual) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A senha atual está incorreta.'),
          ),
        );
        return;
      }

      await DatabaseHelper.instance.atualizarCliente(
        widget.cliente['id'],
        {
          'senha': novaSenha,
        },
      );

      if (!mounted) {
        return;
      }

      _senhaAtualController.clear();
      _novaSenhaController.clear();
      _confirmarSenhaController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senha alterada com sucesso.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          alterandoSenha = false;
        });
      }
    }
  }

  Future<void> eliminarConta() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar conta'),
          content: const Text(
            'Deseja realmente eliminar a sua conta? '
            'Todos os dados serão removidos.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    await DatabaseHelper.instance.eliminarCliente(
      widget.cliente['id'],
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Conta eliminada com sucesso.',
        ),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginClientePage(),
      ),
      (route) => false,
    );
  }

  InputDecoration campoSenhaDecoracao({
    required String label,
    required bool mostrar,
    required VoidCallback alternar,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(
          mostrar ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: alternar,
      ),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: visualizarFoto,
              child: CircleAvatar(
                radius: 55,
                backgroundImage:
                    fotoAtual != null && fotoAtual!.isNotEmpty
                        ? FileImage(File(fotoAtual!))
                        : null,
                child: fotoAtual == null || fotoAtual!.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 60,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Toque na foto para visualizar ou alterar',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nome'),
                subtitle: Text(
                  widget.cliente['nome'] ?? '',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Contacto'),
                subtitle: Text(
                  widget.cliente['telefone'] ??
                      widget.cliente['email'] ??
                      '',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lock),
                        SizedBox(width: 10),
                        Text(
                          'Alterar senha',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    TextField(
                      controller: _senhaAtualController,
                      obscureText: !mostrarSenhaAtual,
                      decoration: campoSenhaDecoracao(
                        label: 'Senha atual',
                        mostrar: mostrarSenhaAtual,
                        alternar: () {
                          setState(() {
                            mostrarSenhaAtual =
                                !mostrarSenhaAtual;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: _novaSenhaController,
                      obscureText: !mostrarNovaSenha,
                      decoration: campoSenhaDecoracao(
                        label: 'Nova senha',
                        mostrar: mostrarNovaSenha,
                        alternar: () {
                          setState(() {
                            mostrarNovaSenha =
                                !mostrarNovaSenha;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: _confirmarSenhaController,
                      obscureText: !mostrarConfirmarSenha,
                      decoration: campoSenhaDecoracao(
                        label: 'Confirmar nova senha',
                        mostrar: mostrarConfirmarSenha,
                        alternar: () {
                          setState(() {
                            mostrarConfirmarSenha =
                                !mostrarConfirmarSenha;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: alterandoSenha
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.key),
                        label: Text(
                          alterandoSenha
                              ? 'A alterar...'
                              : 'Alterar senha',
                        ),
                        onPressed:
                            alterandoSenha ? null : alterarSenha,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.delete_forever,
                ),
                label: const Text(
                  'Eliminar minha conta',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: eliminarConta,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

