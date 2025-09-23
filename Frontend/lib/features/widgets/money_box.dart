import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoneyBox extends StatefulWidget {
  const MoneyBox({super.key});

  @override
  State<MoneyBox> createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  int counter = 388333;

  void addClick() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset("assets/dollar_coin.svg", scale: 15),
            // SvgPicture.asset(
            //   "assets/big_dollar_coin.svg",
            //   alignment: AlignmentGeometry.center,
            // ),
            // Container(height: 50, width: 50, color: Colors.red),
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: Image.asset("assets/coin.jpg"),
            ),
            SizedBox(width: 2.w),
            Text(
              counter.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
