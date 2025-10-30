import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class InfoBoxes extends StatelessWidget {
  InfoBoxes({super.key, required this.onTap});

  final void Function()? onTap;
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * scale),
      child: Container(
        width: 318 * scale,
        height: 50 * scale,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 40 * scale,
              spreadRadius: 15 * scale,
              offset: Offset(0, 0),
              color: Color.fromARGB(46, 225, 0, 255),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.35), // shadow color
              offset: Offset(0, 4 * scale), // x, y offset (only vertical)
              blurRadius: 8 * scale, // how soft the shadow is
              spreadRadius: 0, // how much the shadow spreads
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50 * scale,
              width: 98 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5 * scale),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15 * scale,
                        height: 15 * scale,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      SizedBox(width: 3 * scale),
                      Text(
                        "+12",
                        style: TextStyle(
                          fontSize: 11 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10 * scale),
            Container(
              height: 50 * scale,
              width: 98 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5 * scale),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15 * scale,
                        height: 15 * scale,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),

                      SizedBox(width: 3 * scale),

                      Text(
                        "10M",
                        style: TextStyle(
                          fontSize: 11 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10 * scale),
            Container(
              height: 50 * scale,
              width: 98 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12 * scale),
                color: Color.fromARGB(196, 39, 39, 39),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5 * scale),
                  Text(
                    "Earn per tap",
                    style: TextStyle(
                      fontSize: 11 * scale,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15 * scale,
                        height: 15 * scale,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      SizedBox(width: 3 * scale),
                      Text(
                        "+678.3K",
                        style: TextStyle(
                          fontSize: 11 * scale,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5 * scale),
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
