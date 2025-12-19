import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'boosters_tab.dart';
import 'package:goose_tap/features/shop/blocs/get_upgrades_bloc/get_upgrades_bloc.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<String> imgList = [
      "assets/shop_imgs/bench_press.png",
      "assets/shop_imgs/tick_tok_bun.png",
      "assets/shop_imgs/dungeon_master.png",
      "assets/shop_imgs/meme.png",
      "assets/shop_imgs/italy.png",
      "assets/shop_imgs/winter_arc.png",
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      // child: FractionallySizedBox(
      //   heightFactor: 0.5,
      //   widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.03),
          color: Color.fromARGB(65, 47, 47, 47),
        ),
        child: selectedIndex == 1
            ? const SizedBox()
            : LayoutBuilder(
                builder: (context, constraints) {
                  return BlocBuilder<GetUpgradesBloc, GetUpgradesState>(
                    builder: (context, state) {
                      if (state is GetUpgradesSuccess) {
                        return GridView.builder(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.04),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: size.width < 450 ? 2 : 3,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: state.upgrades.length,

                          itemBuilder: (context, index) {
                            final upgrade = state.upgrades[index];
                            final img = imgList[index % imgList.length]; // Safe image access
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<GetUpgradesBloc>()
                                    .add(OnBuyUpgradeEvent(upgrade.id));
                              },
                              child: ShopBox(
                                img: img,
                                level: "lvl ${upgrade.currentLevel}",
                                moneyToBuy: upgrade.price.toString(),
                                possibleMoney: upgrade.effectValue.toString(),
                                profitType: "Profit per tap",
                                title: upgrade.name,
                              ),
                            );
                          },
                        );
                      } else if (state is GetUpgradesFailure) {
                        return Center(child: Text(state.errorMessage));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                },
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.035),
          color: Color.fromARGB(67, 47, 47, 47),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.025,
                right: size.width * 0.025,
                top: size.width * 0.03,
                bottom: size.width * 0.012,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    child: Image.asset(img),
                  ),
                  SizedBox(width: size.width * 0.025),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.018,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.005),
                      Text(
                        profitType,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: size.width * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.004),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.width * 0.03,
                            child: Image.asset("assets/exchange_imgs/coin.png"),
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            possibleMoney,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.026,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
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
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.02),
                  Text(
                    level,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.028,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    height: 25,
                    width: 0.5,
                    color: const Color.fromARGB(44, 158, 158, 158),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.03,
                        child: Image.asset("assets/exchange_imgs/coin.png"),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Text(
                        moneyToBuy,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.025,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
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
