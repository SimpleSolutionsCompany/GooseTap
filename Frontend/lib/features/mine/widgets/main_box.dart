import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainBox extends StatelessWidget {
  const MainBox({super.key, required this.cardName, required this.cardImg});

  final String cardName;
  final String cardImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117.w,
      height: 109.h,
      decoration: BoxDecoration(
        color: Color(0xFF32363C),
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [Color(0xFFBFFF98), Color(0xFF32363C)], // your gradient
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: Color(0xFF32363C), // your inner background
          borderRadius: BorderRadius.circular(11.r), // slightly smaller
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(cardImg),
            SizedBox(height: 5.h),
            Text(
              cardName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 7.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
