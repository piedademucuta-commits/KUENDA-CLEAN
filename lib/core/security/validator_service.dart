class ValidatorService {



  // =====================================================
  // VALIDAR CAMPO OBRIGATÓRIO
  // =====================================================


  static bool obrigatorio(

    String? valor,

  ) {


    return valor != null &&

        valor.trim().isNotEmpty;


  }









  // =====================================================
  // VALIDAR EMAIL
  // =====================================================


  static bool email(

    String valor,

  ) {


    final regex = RegExp(

      r'^[\w\.-]+@[\w\.-]+\.\w+$',

    );



    return regex.hasMatch(

      valor.trim(),

    );


  }









  // =====================================================
  // VALIDAR TELEFONE
  // =====================================================


  static bool telefone(

    String valor,

  ) {


    final regex = RegExp(

      r'^[0-9]{9,15}$',

    );



    return regex.hasMatch(

      valor.replaceAll(

        RegExp(r'\s+'),

        '',

      ),

    );


  }









  // =====================================================
  // VALIDAR PASSWORD
  // =====================================================


  static bool password(

    String valor,

  ) {


    // mínimo 6 caracteres

    return valor.length >= 6;


  }









  // =====================================================
  // VALIDAR PIN
  // =====================================================


  static bool pin(

    String valor,

  ) {


    final regex = RegExp(

      r'^[0-9]{4,6}$',

    );



    return regex.hasMatch(valor);


  }









  // =====================================================
  // CONFIRMAR PASSWORD
  // =====================================================


  static bool confirmarPassword(

    String password,

    String confirmacao,

  ) {


    return password == confirmacao;


  }









  // =====================================================
  // VALIDAR NOME
  // =====================================================


  static bool nome(

    String valor,

  ) {


    return valor.trim().length >= 3;


  }









  // =====================================================
  // VALIDAR CÓDIGO OTP
  // =====================================================


  static bool codigoOtp(

    String valor,

  ) {


    final regex = RegExp(

      r'^[0-9]{6}$',

    );



    return regex.hasMatch(valor);


  }



}