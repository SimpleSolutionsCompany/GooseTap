import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goose_tap/features/airdrop/view/airdrop_screen.dart';
import 'package:goose_tap/features/earn/earn.dart';
import 'package:goose_tap/features/friends/friends.dart';

import '../exchange/view/exchange_screen.dart';
import '../mine/view/mine_screen.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2F35),
      body: _selectedIndex == 0
          ? ExchangeScreen()
          : _selectedIndex == 1
          ? MineScreen()
          : _selectedIndex == 2
          ? FriendsScreen()
          : _selectedIndex == 3
          ? EarnScreen()
          : AirdropScreen(),

      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 20,
          right: 20,
          top: 5,
          bottom: 40,
        ),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFF32363C),
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? Color(0xFF212429)
                          : Color(0xFF32363C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                "assets/bottom_nav_bar_imgs/binance.svg",
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Exchange",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? Color(0xFF212429)
                          : Color(0xFF32363C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                "assets/bottom_nav_bar_imgs/pickaxe.svg",
                                // color: Color(0xFFD9D9D9),
                                color: const Color.fromARGB(255, 94, 94, 94),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Mine",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2
                          ? Color(0xFF212429)
                          : Color(0xFF32363C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                "assets/bottom_nav_bar_imgs/friends.svg",
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Friends",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(3),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 3
                          ? Color(0xFF212429)
                          : Color(0xFF32363C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                "assets/bottom_nav_bar_imgs/coins.svg",
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Earn",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(4),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: _selectedIndex == 4
                          ? Color(0xFF212429)
                          : Color(0xFF32363C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              //TODO: update the image
                              // child: SvgPicture.asset(
                              //   "assets/bottom_nav_bar_imgs/goose_coin.svg",
                              // ),
                              child: Container(
                                height: 50,
                                width: 50,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Airdrop",
                            style: TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
