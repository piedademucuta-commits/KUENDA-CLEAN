import 'dart:math';
import 'package:flutter/material.dart';

/// Classe base para geração de elementos gráficos do KUENDA CLEAN.
class ImageGenerator {
  static const Color primary = Color(0xFF2ECC71);
  static const Color secondary = Color(0xFF27AE60);
  static const Color dark = Color(0xFF0D1B2A);
  static const Color blue = Color(0xFF3498DB);
  static const Color white = Colors.white;

  static const List<Color> palette = [
    primary,
    secondary,
    dark,
    blue,
    white,
  ];

  /// Cor aleatória da paleta.
  static Color randomColor() {
    final random = Random();
    return palette[random.nextInt(palette.length)];
  }

  /// Gradiente principal.
  static LinearGradient defaultGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primary,
        secondary,
      ],
    );
  }

  /// Gradiente para splash.
  static LinearGradient splashGradient() {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFEFFFF5),
        Color(0xFFCFF5E3),
        primary,
      ],
    );
  }

  /// Cartão padrão.
  static BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 5),
        )
      ],
    );
  }

  /// Fundo principal.
  static BoxDecoration backgroundDecoration() {
    return BoxDecoration(
      gradient: defaultGradient(),
    );
  }

  /// Fundo claro.
  static BoxDecoration lightBackground() {
    return const BoxDecoration(
      color: Color(0xFFF5F7FA),
    );
  }

  /// Espaçamento padrão.
  static const EdgeInsets padding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);

  /// Título padrão.
  static TextStyle titleStyle() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: dark,
    );
  }

  /// Subtítulo.
  static TextStyle subtitleStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black54,
    );
  }

  /// Botão padrão.
  static ButtonStyle primaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  /// Ícones do sistema.
  static const List<IconData> cleaningIcons = [
    Icons.cleaning_services,
    Icons.home,
    Icons.local_laundry_service,
    Icons.sanitizer,
    Icons.water_drop,
    Icons.shield,
    Icons.workspace_premium,
    Icons.eco,
  ];

  static IconData randomIcon() {
    final random = Random();
    return cleaningIcons[random.nextInt(cleaningIcons.length)];
  }
}