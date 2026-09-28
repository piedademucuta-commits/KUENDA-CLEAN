import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  AppHelpers._();

  // ==========================
  // SNACKBAR
  // ==========================

  static void mostrarMensagem(
    BuildContext context,
    String mensagem, {
    bool erro = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor:
            erro ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


  // ==========================
  // VALIDAÇÕES
  // ==========================

  static bool emailValido(String email) {
    final regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    return regex.hasMatch(email);
  }


  static bool telefoneValido(String telefone) {
    final numero =
        telefone.replaceAll(RegExp(r'\D'), '');

    return numero.length >= 9;
  }


  static bool campoVazio(String? valor) {
    return valor == null ||
        valor.trim().isEmpty;
  }


  // ==========================
  // FORMATAÇÃO
  // ==========================

  static String formatarData(
    DateTime data,
  ) {
    return DateFormat(
      'dd/MM/yyyy',
    ).format(data);
  }


  static String formatarDataHora(
    DateTime data,
  ) {
    return DateFormat(
      'dd/MM/yyyy HH:mm',
    ).format(data);
  }


  static String formatarTelefone(
    String telefone,
  ) {
    final numero =
        telefone.replaceAll(RegExp(r'\D'), '');

    if (numero.length == 9) {
      return '${numero.substring(0,3)} '
          '${numero.substring(3,6)} '
          '${numero.substring(6)}';
    }

    return telefone;
  }


  // ==========================
  // TEXTO
  // ==========================

  static String primeiraLetraMaiuscula(
    String texto,
  ) {
    if (texto.isEmpty) {
      return texto;
    }

    return texto[0].toUpperCase() +
        texto.substring(1).toLowerCase();
  }


  static String limitarTexto(
    String texto,
    int limite,
  ) {
    if (texto.length <= limite) {
      return texto;
    }

    return '${texto.substring(0, limite)}...';
  }


  // ==========================
  // PEDIDOS
  // ==========================

  static Color corEstadoPedido(
    String estado,
  ) {
    switch (estado.toLowerCase()) {
      case 'pendente':
        return Colors.orange;

      case 'confirmado':
        return Colors.blue;

      case 'em andamento':
        return Colors.purple;

      case 'concluído':
        return Colors.green;

      case 'cancelado':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }


  // ==========================
  // DADOS
  // ==========================

  static String valorSeguro(
    dynamic valor,
  ) {
    if (valor == null) {
      return '';
    }

    return valor.toString();
  }
}