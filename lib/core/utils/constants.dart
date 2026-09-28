import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // ==========================
  // APP
  // ==========================

  static const String appName = 'Kuenda Clean';

  static const String appVersion = '1.0.0';

  // ==========================
  // ADMIN
  // ==========================

  static const String adminEmail = 'admin@kuendaclean.com';

  static const String adminPassword = '123456';

  static const String adminName = 'Administrador';

  // ==========================
  // ESTADOS DOS PEDIDOS
  // ==========================

  static const String pedidoPendente = 'Pendente';

  static const String pedidoConfirmado = 'Confirmado';

  static const String pedidoEmAndamento = 'Em andamento';

  static const String pedidoConcluido = 'Concluído';

  static const String pedidoCancelado = 'Cancelado';

  static const List<String> estadosPedido = [
    pedidoPendente,
    pedidoConfirmado,
    pedidoEmAndamento,
    pedidoConcluido,
    pedidoCancelado,
  ];

  // ==========================
  // SERVIÇOS
  // ==========================

  static const List<String> servicos = [
    'Limpeza Residencial',
    'Limpeza Comercial',
    'Limpeza Pós-Obra',
    'Limpeza de Escritórios',
    'Limpeza Profunda',
    'Lavagem de Sofás',
    'Lavagem de Tapetes',
    'Lavagem de Colchões',
    'Jardinagem',
    'Desinfeção',
  ];

  // ==========================
  // CONTACTOS
  // ==========================

  static const String telefone = '+244 900 000 000';

  static const String email = 'contacto@kuendaclean.com';

  static const String website = 'www.kuendaclean.com';

  // ==========================
  // MENSAGENS
  // ==========================

  static const String erroGenerico =
      'Ocorreu um erro. Tente novamente.';

  static const String semInternet =
      'Sem ligação à Internet.';

  static const String sucesso =
      'Operação realizada com sucesso.';
}

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1565C0);

  static const Color secondary = Color(0xFF00ACC1);

  static const Color success = Color(0xFF2E7D32);

  static const Color warning = Color(0xFFF9A825);

  static const Color danger = Color(0xFFC62828);

  static const Color background = Color(0xFFF5F7FA);

  static const Color card = Colors.white;

  static const Color text = Color(0xFF212121);

  static const Color subtitle = Color(0xFF757575);
}

class AppPadding {
  AppPadding._();

  static const double xs = 4;

  static const double sm = 8;

  static const double md = 16;

  static const double lg = 24;

  static const double xl = 32;
}

class AppRadius {
  AppRadius._();

  static const BorderRadius small =
      BorderRadius.all(Radius.circular(8));

  static const BorderRadius medium =
      BorderRadius.all(Radius.circular(12));

  static const BorderRadius large =
      BorderRadius.all(Radius.circular(20));
}

class AppDuration {
  AppDuration._();

  static const Duration fast =
      Duration(milliseconds: 200);

  static const Duration normal =
      Duration(milliseconds: 350);

  static const Duration slow =
      Duration(milliseconds: 600);
}