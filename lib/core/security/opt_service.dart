import 'dart:math';



class OtpService {



  // =====================================================
  // CONFIGURAÇÕES
  // =====================================================


  static const int tamanhoCodigo = 6;


  static const int validadeMinutos = 10;









  // =====================================================
  // GERAR CÓDIGO OTP
  // =====================================================


  static String gerarCodigo() {


    final random = Random();



    String codigo = "";



    for (int i = 0; i < tamanhoCodigo; i++) {


      codigo += random

          .nextInt(10)

          .toString();


    }



    return codigo;


  }









  // =====================================================
  // DATA DE EXPIRAÇÃO
  // =====================================================


  static DateTime gerarExpiracao() {


    return DateTime.now().add(

      const Duration(

        minutes: validadeMinutos,

      ),

    );


  }









  // =====================================================
  // VALIDAR CÓDIGO
  // =====================================================


  static bool validarCodigo(

    String codigoDigitado,

    String codigoGuardado,

    DateTime expiracao,

  ) {


    if (DateTime.now().isAfter(expiracao)) {


      return false;


    }





    return codigoDigitado == codigoGuardado;


  }









  // =====================================================
  // GERAR DADOS COMPLETOS
  // =====================================================


  static Map<String, dynamic> criarOtp() {


    final codigo = gerarCodigo();



    return {


      "codigo": codigo,


      "expiracao":

          gerarExpiracao()

              .toIso8601String(),


    };


  }



}