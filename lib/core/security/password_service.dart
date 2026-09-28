import 'dart:convert';
import 'package:crypto/crypto.dart';


class PasswordService {



  // =====================================================
  // GERAR HASH DA PASSWORD
  // =====================================================


  static String gerarHash(

    String password,

  ) {


    final bytes =

        utf8.encode(password);



    final digest =

        sha256.convert(bytes);



    return digest.toString();


  }









  // =====================================================
  // VALIDAR PASSWORD
  // =====================================================


  static bool validar(

    String passwordDigitada,

    String passwordHash,

  ) {


    final hashDigitado =

        gerarHash(passwordDigitada);



    return hashDigitado == passwordHash;


  }



}