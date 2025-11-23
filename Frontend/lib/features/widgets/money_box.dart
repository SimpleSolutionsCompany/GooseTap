import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MoneyBox extends StatefulWidget {
  const MoneyBox({super.key, required this.counter});

  final int counter;

  @override
  State<MoneyBox> createState() => _MoneyBoxState();
}

class _MoneyBoxState extends State<MoneyBox> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        // width: 200,
        // height: 50,
        width: width * 0.8,
        height: height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
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
            SizedBox(width: 2),
            Text(
              widget.counter.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
