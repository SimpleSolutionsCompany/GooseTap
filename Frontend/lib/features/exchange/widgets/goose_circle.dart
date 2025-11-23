import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GooseCircle extends StatefulWidget {
  const GooseCircle({super.key, required this.counter, required this.onTapUp});

  final int counter;
  final void Function(TapUpDetails) onTapUp;

  @override
  State<GooseCircle> createState() => _GooseCircleState();
}

class _GooseCircleState extends State<GooseCircle>
    with SingleTickerProviderStateMixin {
  final getIt = GetIt.instance;
  // late BounceController _bounceController;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280), // smoother
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08, // overshoot amount
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap(TapUpDetails details) {
    _animationController.forward(from: 0.0); // always restarts
    widget.onTapUp(details);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final double outer = width * 0.72;
    final double inner = width * 0.67;
    final double gooseWidth = width * 0.70;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: _handleTap,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  width: outer,
                  height: outer,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(61, 225, 0, 255),
                        offset: Offset(0, 20),
                        spreadRadius: 8,
                        blurRadius: 180,
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
                ClipOval(
                  child: Container(
                    width: outer,
                    height: outer,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -200),
                          color: Colors.white.withOpacity(0.25),
                          blurRadius: 50,
                          spreadRadius: 20,
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

                Container(
                  width: inner,
                  height: inner,
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
                  right: outer * 0.06,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: outer * 0.32,
                      sigmaY: outer * 0.32,
                    ),
                    child: Container(
                      width: outer * 0.62,
                      height: outer * 0.62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: outer * 0.06,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: outer * 0.1,
                      sigmaY: outer * 0.1,
                    ),
                    child: Container(
                      width: outer * 0.62,
                      height: outer * 0.62,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: gooseWidth,
                    height: gooseWidth * 0.9,
                    child: Image.asset("assets/exchange_imgs/goose.png"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
