import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InfoBoxes extends StatelessWidget {
  final void Function()? onTap;
  const InfoBoxes({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        width: 318.w,
        height: 50.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 40,
              spreadRadius: 15,
              offset: Offset(0, 0),
              color: Color.fromARGB(46, 225, 0, 255),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.35), // shadow color
              offset: const Offset(0, 4), // x, y offset (only vertical)
              blurRadius: 8, // how soft the shadow is
              spreadRadius: 0, // how much the shadow spreads
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50.h,
              width: 98.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        "+12",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              height: 50.h,
              width: 98.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),

                      SizedBox(width: 3.w),

                      Text(
                        "10M",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              height: 50.h,
              width: 98.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      // Image.asset("assets/coin.png"),
                      SizedBox(width: 3.w),
                      Text(
                        "+678.3K",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      GestureDetector(
                        onTap: onTap,
                        child: SvgPicture.asset(
                          "assets/exchange_imgs/info.svg",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
