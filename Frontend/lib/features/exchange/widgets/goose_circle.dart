import 'package:flutter/material.dart';

class GooseCircle extends StatelessWidget {
  const GooseCircle({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlue.withOpacity(0.2),
                    offset: Offset(0.2, 0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Color(0xFF5155DA), Color(0xFF2B2D74)],
                ),
              ),
            ),
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(145),
                gradient: LinearGradient(
                  colors: [Color(0xFF35389E), Color(0xFF1C2848)],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: RadialGradient(
                    radius: 1,
                    colors: [
                      Color(0xAA5155da).withOpacity(0.8),
                      Color(0x005155da),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Image.asset("assets/goose.PNG", scale: 3.5),
          ],
        ),
      ),
    );
  }
}
