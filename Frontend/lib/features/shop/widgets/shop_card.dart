import 'package:flutter/material.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    List<String> imgList = [
      "assets/shop_imgs/italy.png",
      "assets/shop_imgs/meme.png",
      "assets/shop_imgs/tick_tok_bun.png",
      "assets/shop_imgs/bench_press.png",
      "assets/shop_imgs/winter_arc.png",
      "assets/shop_imgs/dungeon_master.png",
    ];
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 40 * scale),
      child: FractionallySizedBox(
        heightFactor: 0.5,
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13 * scale),
            color: Color.fromARGB(65, 47, 47, 47),
          ),
          child: selectedIndex == 1
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15 * scale),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // width: 365 * scale,
                        // height: 365 * scale,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Image.asset(
                          "assets/comming_soon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 50 * scale),
                      Text(
                        "COMMING SOON...)))",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * scale,
                    vertical: 20 * scale,
                  ),

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.32,
                  ),
                  itemCount: 6,

                  itemBuilder: (context, index) {
                    return ShopBox(
                      img: imgList[index],
                      level: "lvl 13",
                      moneyToBuy: "156.92K",
                      possibleMoney: "1.61K",
                      profitType: "Profit per hour",
                      title: "ITALLIIAAA!!!",
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class ShopBox extends StatelessWidget {
  const ShopBox({
    super.key,
    required this.img,
    required this.title,
    required this.profitType,
    required this.possibleMoney,
    required this.level,
    required this.moneyToBuy,
  });

  final String img;
  final String title;
  final String profitType;
  final String possibleMoney;
  final String level;
  final String moneyToBuy;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    return Padding(
      padding: EdgeInsetsGeometry.all(4 * scale),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * scale),
          color: Color.fromARGB(67, 47, 47, 47),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10 * scale,
                right: 10 * scale,
                top: 15 * scale,
                bottom: 5 * scale,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 44 * scale,
                    width: 44 * scale,
                    child: Image.asset(img),
                  ),
                  SizedBox(width: 12 * scale),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        profitType,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12 * scale,
                            width: 12 * scale,
                            child: Image.asset("assets/exchange_imgs/coin.png"),
                          ),
                          SizedBox(width: 2 * scale),
                          Text(
                            possibleMoney,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.2 * scale,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: const Color.fromARGB(22, 158, 158, 158),
              height: 0.5,
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10 * scale,
                right: 10 * scale,
                top: 5 * scale,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 6 * scale),
                  Text(
                    level,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10 * scale),
                  Container(
                    height: 25 * scale,
                    width: 0.5 * scale,
                    color: const Color.fromARGB(44, 158, 158, 158),
                  ),
                  SizedBox(width: 15 * scale),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15 * scale,
                        width: 15 * scale,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      SizedBox(width: 4 * scale),
                      Text(
                        moneyToBuy,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
