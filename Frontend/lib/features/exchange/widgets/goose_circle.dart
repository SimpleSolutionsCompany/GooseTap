import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class GooseCircle extends StatefulWidget {
  const GooseCircle({super.key, required this.counter, required this.onTapUp});

  final int counter;
  final void Function(TapUpDetails) onTapUp;

  @override
  State<GooseCircle> createState() => _GooseCircleState();
}

class _GooseCircleState extends State<GooseCircle> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: widget.onTapUp,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 323 * scale,
            height: 323 * scale,
            // width: width * 0.08,
            // height: height * 0.04,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(61, 225, 0, 255),
                  offset: Offset(0, 20 * scale),
                  spreadRadius: 8 * scale,
                  blurRadius: 180 * scale,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(114, 136, 0, 255),
                  Color.fromARGB(115, 21, 2, 58),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Inner shadow overlay
          IgnorePointer(
            child: ClipOval(
              child: Container(
                width: 323 * scale,
                height: 323 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -200 * scale),
                      color: Colors.white.withOpacity(0.25),
                      blurRadius: 50 * scale,
                      spreadRadius: 20 * scale,
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 294 * scale,
            height: 294 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF8800FF), Color(0xFF15023A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            right: 20 * scale,

            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 105 * scale,
                sigmaY: 105 * scale,
              ),
              child: Container(
                width: 200 * scale,
                height: 200 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20 * scale,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 35 * scale,
                sigmaY: 35 * scale,
              ),
              child: Container(
                width: 200 * scale,
                height: 200 * scale,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ),
          //TODO: make the goose responsive
          Image.asset("assets/exchange_imgs/goose.png", scale: 4),
        ],
      ),
    );
  }
}
