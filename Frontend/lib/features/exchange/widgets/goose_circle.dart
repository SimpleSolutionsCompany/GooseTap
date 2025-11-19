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
      // 1. Made the animation faster for a "snappier" clicker feel
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        // 2. "Squish" down (same as before)
        tween: Tween(
          begin: 1.0,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30, // Use 30% of the duration
      ),
      TweenSequenceItem(
        // 3. "Overshoot" past 1.0 to 1.05
        tween: Tween(
          begin: 0.9,
          end: 1.05,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40, // Use 40% of the duration
      ),
      TweenSequenceItem(
        // 4. "Settle" back down to 1.0
        tween: Tween(
          begin: 1.05,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30, // Use 30% of the duration
      ),
    ]).animate(_animationController);

    // 5. REMOVED the addListener(setState) calls.
    // We will use AnimatedBuilder in the build method instead.
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap(TapUpDetails details) {
    if (_animationController.status != AnimationStatus.forward) {
      _animationController.forward(from: 0.0);
    }
    widget.onTapUp(details);
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 323,
                  height: 323,

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
                IgnorePointer(
                  child: ClipOval(
                    child: Container(
                      width: 323,
                      height: 323,
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
                ),

                Container(
                  width: 294,
                  height: 294,
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
                  right: 20,

                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 105, sigmaY: 105),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                    child: Container(
                      width: 200,
                      height: 200,

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
                    width: 300,
                    height: 270,
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
