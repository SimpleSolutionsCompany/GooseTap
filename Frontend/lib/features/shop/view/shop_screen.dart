import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/features/shop/shop.dart';
import 'package:goose_tap/features/widgets/widgets.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedIndex = 0;

  void switchPanels(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
    log("Selected index is: $selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/gradient_bg_purple2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100 * scale,
            child: InfoBoxes(onTap: () {}),
          ),
          Positioned(top: 170, child: MoneyBox(counter: 1000)),
          Positioned(
            top: 270,
            child: PanelSwitcher(
              selectedIndex: selectedIndex,
              onChanged: switchPanels,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ShopCard(selectedIndex: selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
