import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get_it/get_it.dart";
import "package:goose_tap/responsiveness/responsiveness.dart";

class UpperInfo extends StatelessWidget {
  UpperInfo({super.key});

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 5 * scale,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 55 * scale,
                height: 55 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15 * scale),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(49, 255, 255, 255),
                      Color(0XAA4E4949),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12 * scale),
                  child: SvgPicture.asset("assets/account_icon.svg"),
                ),
              ),
              SizedBox(width: 15 * scale),
              Text(
                "Nick Jay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            width: 90 * scale,
            height: 55 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * scale),
              gradient: LinearGradient(
                colors: [Color.fromARGB(49, 255, 255, 255), Color(0XAA4E4949)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6 * scale),
              child: Row(
                children: [
                  SvgPicture.asset("assets/binance_logo.svg"),
                  SizedBox(width: 5 * scale),
                  Text(
                    "Binance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * scale,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
