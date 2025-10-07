import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      height: 107.56.h,
      decoration: BoxDecoration(
        color: Color(0xFF32363C),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(children: [
             
          ],
        ),
      ),
    );
  }
}
