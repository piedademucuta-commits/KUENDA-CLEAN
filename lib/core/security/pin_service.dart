import 'password_service.dart';



class PinService {



  // =====================================================
  // GERAR HASH DO PIN
  // =====================================================


  static String gerarHash(

    String pin,

  ) {


    return PasswordService.gerarHash(

      pin,

    );


  }









  // =====================================================
  // VALIDAR PIN
  // =====================================================


  static bool validar(

    String pinDigitado,

    String pinHash,

  ) {


    return PasswordService.validar(

      pinDigitado,

      pinHash,

    );


  }



}