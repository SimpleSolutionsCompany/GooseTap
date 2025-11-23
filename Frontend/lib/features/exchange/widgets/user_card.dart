import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose_tap/features/exchange/widgets/widgets.dart';
import 'package:goose_tap/features/widgets/widgets.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.counter, required this.progress});

  final int counter;
  final double progress;
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.09),
            child: Container(
              // width: 358,
              // height: 213,
              width: width * 0.9,
              height: height * 0.23,
              decoration: BoxDecoration(
                color: const Color.fromARGB(125, 0, 0, 0),
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    spreadRadius: 20,
                    offset: Offset(2, 2),
                    color: Color.fromARGB(61, 225, 0, 255),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 32,
                              child: Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Color(0xFF4C0061),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.2),
                                      blurRadius: 3,
                                      offset: Offset(3, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Color(0xFFFF0004),
                                    width: 2.5,
                                  ),
                                ),
                                child: Image.asset(
                                  "assets/exchange_imgs/goose.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: Color(0xFFFFEA00),
                                  width: 2.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Image.asset(
                                  "assets/exchange_imgs/me.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Semeniuk Vlad",
                            style: GoogleFonts.sarpanch(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
          ),
        ],
      ),
    );
  }
}
