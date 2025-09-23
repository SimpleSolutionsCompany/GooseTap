import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DailyComboBox extends StatelessWidget {
  const DailyComboBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
      child: Container(
        height: 41.h,
        decoration: BoxDecoration(
          color: Color(0xFF32363C),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 6.w),
                  Text(
                    "Daily combo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                width: 122.w,
                height: 39.h,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2D32),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(color: Colors.red, width: 15.w, height: 15.h),
                    SizedBox(width: 6.w),
                    Text(
                      "5,000,000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    SvgPicture.asset("assets/mine_imgs/success.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
