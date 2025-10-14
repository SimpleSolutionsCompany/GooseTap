import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goose_tap/features/exchange/widgets/widgets.dart';

class GooseCircle extends StatefulWidget {
  const GooseCircle({super.key, required this.counter, required this.onTapUp});

  final int counter;
  final void Function(TapUpDetails) onTapUp;

  @override
  State<GooseCircle> createState() => _GooseCircleState();
}

class _GooseCircleState extends State<GooseCircle> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // final height = constraints.maxHeight;
          // final width = constraints.maxWidth;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: widget.onTapUp,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 323.w,
                  height: 323.h,
                  // width: width * 0.9,
                  // height: height * 0.4,
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
                      //TODO: Oval proble with iphones
                      width: 323.w,
                      height: 323.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(170.r),
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
                  width: 294.w,
                  height: 294.h,
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
                  right: 20.w,
                  // bottom: 20.w,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 105, sigmaY: 105),
                    child: Container(
                      width: 200.w,
                      height: 200.h,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                    child: Container(
                      width: 200.w,
                      height: 200.h,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),

                Image.asset("assets/exchange_imgs/goose.png", scale: 4),
              ],
            ),
          );
        },
      ),
    );
  }
}

//try this later -> study this code

// class GooseCircle extends StatelessWidget {
//   const GooseCircle({super.key, required this.onTap});

//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Center(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final size = constraints.maxWidth < constraints.maxHeight
//                 ? constraints.maxWidth
//                 : constraints.maxHeight; // take smaller dimension
//             final outerCircleSize = size * 0.9;
//             final innerCircleSize = size * 0.8;
//             final overlayBlurSize = size * 0.6;

//             return Stack(
//               alignment: Alignment.center,
//               clipBehavior: Clip.none,
//               children: [
//                 // Outer Gradient + Shadow
//                 Container(
//                   width: outerCircleSize,
//                   height: outerCircleSize,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(outerCircleSize / 2),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color.fromARGB(61, 225, 0, 255),
//                         offset: Offset(0, size * 0.06),
//                         spreadRadius: size * 0.025,
//                         blurRadius: size * 0.55,
//                       ),
//                     ],
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(114, 136, 0, 255),
//                         Color.fromARGB(115, 21, 2, 58),
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),

//                 // Inner shadow overlay
//                 ClipOval(
//                   child: Container(
//                     width: outerCircleSize,
//                     height: outerCircleSize,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(outerCircleSize / 2),
//                       boxShadow: [
//                         BoxShadow(
//                           offset: Offset(0, -size * 0.2),
//                           color: Colors.white.withOpacity(0.25),
//                           blurRadius: size * 0.15,
//                           spreadRadius: size * 0.05,
//                         ),
//                       ],
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Colors.white.withOpacity(0.15),
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.4),
//                         ],
//                         stops: const [0.0, 0.5, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Inner Gradient Circle
//                 Container(
//                   width: innerCircleSize,
//                   height: innerCircleSize,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(innerCircleSize / 2),
//                     gradient: LinearGradient(
//                       colors: [Color(0xFF8800FF), Color(0xFF15023A)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),

//                 // Right Overlay Blur
//                 Positioned(
//                   right: size * 0.05,
//                   child: ImageFiltered(
//                     imageFilter: ImageFilter.blur(
//                       sigmaX: overlayBlurSize * 0.525,
//                       sigmaY: overlayBlurSize * 0.525,
//                     ),
//                     child: Container(
//                       width: overlayBlurSize,
//                       height: overlayBlurSize,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           overlayBlurSize / 2,
//                         ),
//                         color: Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Left Overlay Blur
//                 Positioned(
//                   left: size * 0.05,
//                   child: ImageFiltered(
//                     imageFilter: ImageFilter.blur(
//                       sigmaX: overlayBlurSize * 0.175,
//                       sigmaY: overlayBlurSize * 0.175,
//                     ),
//                     child: Container(
//                       width: overlayBlurSize,
//                       height: overlayBlurSize,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           overlayBlurSize / 2,
//                         ),
//                         color: Colors.black.withOpacity(0.7),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Goose Image (scaled proportionally)
//                 Image.asset(
//                   "assets/exchange_imgs/goose.png",
//                   width: innerCircleSize * 0.8,
//                   height: innerCircleSize * 0.8,
//                   fit: BoxFit.contain,
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
