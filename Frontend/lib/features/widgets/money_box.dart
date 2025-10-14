import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyBox extends StatefulWidget {
  MoneyBox({super.key, required this.counter});

  int counter;

  @override
  State<MoneyBox> createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.w,
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.25), // shadow color
                    spreadRadius: 0.5, // how much the shadow spreads
                    blurRadius: 10, // how soft the shadow is
                    offset: Offset(0, 4), // x and y offset
                  ),
                ],
              ),
              child: Image.asset("assets/exchange_imgs/coin.png"),
            ),
            SizedBox(width: 2.w),
            Text(
              widget.counter.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
