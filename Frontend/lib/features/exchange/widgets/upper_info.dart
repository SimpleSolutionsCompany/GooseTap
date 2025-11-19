import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get_it/get_it.dart";

class UpperInfo extends StatelessWidget {
  UpperInfo({super.key});

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
                  padding: EdgeInsets.all(12),
                  child: SvgPicture.asset("assets/account_icon.svg"),
                ),
              ),
              SizedBox(width: 15),
              Text(
                "Nick Jay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            width: 90,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Color.fromARGB(49, 255, 255, 255), Color(0XAA4E4949)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Row(
                children: [
                  SvgPicture.asset("assets/binance_logo.svg"),
                  SizedBox(width: 5),
                  Text(
                    "Binance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
