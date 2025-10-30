import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

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
    final scale = getIt<Responsiveness>().scale;
    return Center(
      child: SizedBox(
        width: 200 * scale,
        height: 50 * scale,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50 * scale,
              width: 50 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withOpacity(0.25), // shadow color
                    spreadRadius: 0.5 * scale, // how much the shadow spreads
                    blurRadius: 10 * scale, // how soft the shadow is
                    offset: Offset(0, 4), // x and y offset
                  ),
                ],
              ),
              child: Image.asset("assets/exchange_imgs/coin.png"),
            ),
            SizedBox(width: 2 * scale),
            Text(
              widget.counter.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 34 * scale,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
