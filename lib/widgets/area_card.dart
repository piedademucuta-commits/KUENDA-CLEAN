import 'package:flutter/material.dart';

class AreaCard extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;

  const AreaCard({
    super.key,
    required this.icon,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 5,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: InkWell(

        borderRadius: BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Icon(
                icon,
                size: 45,
                color: colorScheme.primary,
              ),


              const SizedBox(height: 15),


              Text(
                titulo,

                textAlign:
                    TextAlign.center,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 8),


              Text(
                descricao,

                textAlign:
                    TextAlign.center,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}