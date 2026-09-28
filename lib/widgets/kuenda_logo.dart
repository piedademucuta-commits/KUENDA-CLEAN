import 'package:flutter/material.dart';


class KuendaLogo extends StatelessWidget {


  final double size;


  const KuendaLogo({

    super.key,

    this.size = 120,

  });



  @override
  Widget build(BuildContext context) {


    return Container(

      width: size,

      height: size,


      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color:

        Theme.of(context)
            .colorScheme
            .primary,


        boxShadow:[


          BoxShadow(

            color:

            Colors.black.withValues(
              alpha:0.15,
            ),

            blurRadius:10,

            offset:

            const Offset(0,5),

          ),


        ],

      ),



      child:

      Icon(

        Icons.cleaning_services,

        size:

        size * 0.55,


        color:

        Colors.white,

      ),


    );


  }


}