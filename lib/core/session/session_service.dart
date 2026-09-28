
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _nome = 'nome';
  static const String _email = 'email';
  static const String _tipo = 'tipo';

  // SALVAR SESSÃƒO
  static Future<void> salvarSessao({
    required String nome,
    required String email,
    required String tipo,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _nome,
      nome,
    );

    await prefs.setString(
      _email,
      email,
    );

    await prefs.setString(
      _tipo,
      tipo,
    );
  }

  // OBTER NOME DO UTILIZADOR
  static Future<String?> obterNome() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      _nome,
    );
  }

  // OBTER EMAIL
  static Future<String?> obterEmail() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      _email,
    );
  }

  // OBTER TIPO DE UTILIZADOR
  static Future<String?> obterTipo() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(
      _tipo,
    );
  }

  // TERMINAR SESSÃƒO
  static Future<void> limparSessao() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}


