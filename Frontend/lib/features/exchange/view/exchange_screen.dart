import "package:flutter/material.dart";
import "package:goose_tap/features/exchange/widgets/widgets.dart";
import "../../widgets/widgets.dart";

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/exchange_imgs/gradient_bg_purple.png",
                    ),
                  ),

                  Positioned(top: height * 0.12, child: UserCard()),

                  Positioned(
                    top: height * 0.38,
                    child: InfoBoxes(onTap: () {}),
                  ),
                  Positioned(
                    top: height * 0.50,
                    child: GooseCircle(onTap: () {}),
                  ),

                  Positioned(top: height * 0.9, child: Energy()),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
