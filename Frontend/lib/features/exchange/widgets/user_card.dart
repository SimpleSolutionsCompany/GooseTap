import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose_tap/features/exchange/widgets/widgets.dart';
import 'package:goose_tap/features/widgets/widgets.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.counter, required this.progress});

  int counter;
  double progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 378.w,
            height: 213.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(125, 0, 0, 0),
              borderRadius: BorderRadius.circular(13.r),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 32.w,
                            child: Container(
                              height: 44.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.r),
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
                            height: 44.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
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
                              borderRadius: BorderRadius.circular(22.r),
                              child: Image.asset(
                                "assets/exchange_imgs/me.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
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
        ],
      ),
    );
  }
}
