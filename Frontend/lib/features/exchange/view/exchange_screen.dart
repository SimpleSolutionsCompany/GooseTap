import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:goose_tap/features/exchange/widgets/energy.dart";
import "package:goose_tap/features/exchange/widgets/upper_info.dart";

import "../widgets/widgets.dart";

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  int counter = 507987;

  void addClick() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2F35),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UpperInfo(),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(45),
                topLeft: Radius.circular(45),
              ),
              border: Border(
                top: BorderSide(color: Color(0xFFF9D838), width: 3.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF9D838).withOpacity(0.4),
                  offset: Offset(0, -35),
                  spreadRadius: 20,
                  blurRadius: 15,
                ),
              ],
              color: Color(0xFF2C2F35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                InfoBoxes(onTap: () {}),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 70,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset("assets/dollar_coin.svg", scale: 15),
                        // SvgPicture.asset(
                        //   "assets/big_dollar_coin.svg",
                        //   alignment: AlignmentGeometry.center,
                        // ),
                        Container(height: 50, width: 50, color: Colors.red),
                        // const SizedBox(width: 2),
                        Text(
                          counter.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const ProgressBar(),
                const SizedBox(height: 30),
                GooseCircle(onTap: () => addClick()),
                const SizedBox(height: 30),
                const Energy(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 0,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: 30,
                //             height: 30,
                //             child: SvgPicture.asset(
                //               "assets/energy.svg",
                //               semanticsLabel: 'Energy',
                //             ),
                //           ),
                //           const SizedBox(width: 5),
                //           Text(
                //             "1000/1000",
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.white,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //         ],
                //       ),
                //       Text(
                //         "Boost",
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.white,
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
