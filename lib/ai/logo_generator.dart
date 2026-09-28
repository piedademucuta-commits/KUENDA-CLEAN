import 'package:flutter/material.dart';
import 'image_generator.dart';

class KuendaCleanLogo extends StatelessWidget {
  final double size;

  const KuendaCleanLogo({
    super.key,
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _LogoPainter(),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final green = Paint()
      ..color = ImageGenerator.primary
      ..style = PaintingStyle.fill;

    final blue = Paint()
      ..color = ImageGenerator.blue
      ..style = PaintingStyle.fill;

    final dark = Paint()
      ..color = ImageGenerator.dark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // ===== Casa =====

    final roof = Path();

    roof.moveTo(w * .18, h * .42);
    roof.lineTo(w * .50, h * .15);
    roof.lineTo(w * .82, h * .42);

    canvas.drawPath(roof, dark);

    final house = Rect.fromLTWH(
      w * .34,
      h * .40,
      w * .32,
      h * .22,
    );

    canvas.drawRect(house, green);

    // Porta

    canvas.drawRect(
      Rect.fromLTWH(
        w * .47,
        h * .50,
        w * .06,
        h * .12,
      ),
      blue,
    );

    // ===== Folha =====

    final leaf = Path();

    leaf.moveTo(w * .12, h * .55);

    leaf.quadraticBezierTo(
      w * .02,
      h * .48,
      w * .12,
      h * .35,
    );

    leaf.quadraticBezierTo(
      w * .22,
      h * .48,
      w * .12,
      h * .55,
    );

    canvas.drawPath(leaf, green);

    // ===== Onda =====

    final wave = Path();

    wave.moveTo(w * .18, h * .68);

    wave.quadraticBezierTo(
      w * .45,
      h * .60,
      w * .82,
      h * .68,
    );

    wave.quadraticBezierTo(
      w * .52,
      h * .76,
      w * .18,
      h * .68,
    );

    canvas.drawPath(wave, blue);

    // ===== Bolhas =====

    canvas.drawCircle(
      Offset(w * .82, h * .22),
      7,
      blue,
    );

    canvas.drawCircle(
      Offset(w * .74, h * .15),
      5,
      green,
    );

    canvas.drawCircle(
      Offset(w * .88, h * .30),
      4,
      green,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class KuendaCleanTitle extends StatelessWidget {
  const KuendaCleanTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        Text(
          "KUENDA",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ImageGenerator.dark,
            letterSpacing: 2,
          ),
        ),

        Text(
          "CLEAN",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: ImageGenerator.primary,
            letterSpacing: 2,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "Limpeza que transforma",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),

      ],
    );
  }
}