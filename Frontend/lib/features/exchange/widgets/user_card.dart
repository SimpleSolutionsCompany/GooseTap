import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose_tap/features/exchange/widgets/widgets.dart';
import 'package:goose_tap/features/widgets/widgets.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.counter, required this.progress});

  final int counter;
  final double progress;
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return Center(
      child: Column(
        children: [
          Container(
            width: 378 * scale,
            height: 213 * scale,
            decoration: BoxDecoration(
              color: const Color.fromARGB(125, 0, 0, 0),
              borderRadius: BorderRadius.circular(13 * scale),
              boxShadow: [
                BoxShadow(
                  blurRadius: 40 * scale,
                  spreadRadius: 20 * scale,
                  offset: Offset(2 * scale, 2 * scale),
                  color: Color.fromARGB(61, 225, 0, 255),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * scale,
                    vertical: 20 * scale,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 32 * scale,
                            child: Container(
                              height: 44 * scale,
                              width: 44 * scale,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22 * scale),
                                color: Color(0xFF4C0061),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    blurRadius: 3 * scale,
                                    offset: Offset(3 * scale, 3 * scale),
                                  ),
                                ],
                                border: Border.all(
                                  color: Color(0xFFFF0004),
                                  width: 2.5 * scale,
                                ),
                              ),
                              child: Image.asset(
                                "assets/exchange_imgs/goose.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 44 * scale,
                            width: 44 * scale,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22 * scale),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 3 * scale,
                                  offset: Offset(3 * scale, 3 * scale),
                                ),
                              ],
                              border: Border.all(
                                color: Color(0xFFFFEA00),
                                width: 2.5 * scale,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22 * scale),
                              child: Image.asset(
                                "assets/exchange_imgs/me.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20 * scale),
                        child: Text(
                          "Semeniuk Vlad",
                          style: GoogleFonts.sarpanch(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MoneyBox(counter: counter),
                Spacer(),
                ProgressBar(progress: progress),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
