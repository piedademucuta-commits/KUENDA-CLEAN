import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class ApoioClientePage extends StatelessWidget {


  const ApoioClientePage({
    super.key,
  });



  // ALTERE AQUI PARA O CONTACTO REAL DA KUENDA CLEAN

  final String telefone = "948715791";





  Future<void> ligar() async {


    final Uri url = Uri.parse(

      "tel:$telefone",

    );



    if(await canLaunchUrl(url)){


      await launchUrl(url);


    }


  }





  Future<void> enviarMensagem() async {


    final Uri url = Uri.parse(

      "sms:$telefone",

    );



    if(await canLaunchUrl(url)){


      await launchUrl(url);


    }


  }







  Future<void> abrirWhatsapp() async {


    final Uri url = Uri.parse(

      "https://wa.me/244$telefone",

    );



    if(await canLaunchUrl(url)){


      await launchUrl(

        url,

        mode: LaunchMode.externalApplication,

      );


    }


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(


        title: const Text(

          "Apoio ao Cliente",

        ),


      ),





      body: Padding(


        padding:

        const EdgeInsets.all(20),



        child: Column(



          children: [





            const Icon(


              Icons.support_agent,


              size: 90,


            ),






            const SizedBox(height:20),





            const Text(


              "Fale com a Kuenda Clean",



              style: TextStyle(


                fontSize:24,


                fontWeight:FontWeight.bold,


              ),



            ),





            const SizedBox(height:10),





            const Text(


              "Escolha uma opção de contacto",



              style: TextStyle(


                fontSize:16,


              ),



            ),





            const SizedBox(height:30),






            SizedBox(



              width:double.infinity,



              child: ElevatedButton.icon(



                icon:

                const Icon(Icons.phone),



                label:

                const Text(

                  "Ligar",

                ),



                onPressed:

                ligar,



              ),



            ),







            const SizedBox(height:15),






            SizedBox(



              width:double.infinity,



              child: ElevatedButton.icon(



                icon:

                const Icon(Icons.message),



                label:

                const Text(

                  "Enviar mensagem",

                ),



                onPressed:

                enviarMensagem,



              ),



            ),







            const SizedBox(height:15),






            SizedBox(



              width:double.infinity,



              child: ElevatedButton.icon(



                icon:

                const Icon(Icons.chat),



                label:

                const Text(

                  "WhatsApp",

                ),



                onPressed:

                abrirWhatsapp,



              ),



            ),





          ],



        ),



      ),



    );



  }



}