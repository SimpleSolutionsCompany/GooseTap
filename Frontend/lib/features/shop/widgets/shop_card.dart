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
          color: const Color.fromARGB(33, 47, 47, 47), // More transparent
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
                                name: upgrade.name,
                                description: upgrade.description,
                                currentLevel: upgrade.currentLevel,
                                maxLevel: upgrade.maxLevel,
                                price: upgrade.price,
                                effectValue: upgrade.effectValue,
                                canBuy: upgrade.canBuy && upgrade.currentLevel < upgrade.maxLevel,
                                typeName: "Multitap",
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
    required this.name,
    required this.description,
    required this.currentLevel,
    required this.maxLevel,
    required this.price,
    required this.effectValue,
    required this.canBuy,
    required this.typeName,
  });

  final String img;
  final String name;
  final String description;
  final int currentLevel;
  final int maxLevel;
  final int price;
  final int effectValue;
  final bool canBuy;
  final String typeName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMaxLevel = currentLevel >= maxLevel;

    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.035),
          color: isMaxLevel
              ? const Color.fromARGB(40, 255, 0, 0) // Subtle red for max level
              : const Color.fromARGB(67, 47, 47, 47),
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.024,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: size.height * 0.002),
                        Text(
                          typeName, // "Multitap"
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
                          children: [
                            SizedBox(
                              height: size.width * 0.03,
                              child: Image.asset("assets/exchange_imgs/coin.png"),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Text(
                              "+$effectValue",
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
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(22, 158, 158, 158),
              height: 0.5,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "lvl $currentLevel",
                    style: TextStyle(
                      color: isMaxLevel ? Colors.red : Colors.white,
                      fontSize: size.width * 0.028,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Container(
                    height: 25,
                    width: 0.5,
                    color: const Color.fromARGB(44, 158, 158, 158),
                  ),
                  const SizedBox(width: 8),
                  if (isMaxLevel)
                    Text(
                      "MAX LEVEL",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                          child: Image.asset("assets/exchange_imgs/coin.png"),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          price.toString(),
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
