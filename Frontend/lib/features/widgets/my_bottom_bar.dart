import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/features/airdrop/view/airdrop_screen.dart';
import 'package:goose_tap/features/earn/earn.dart';
import 'package:goose_tap/features/friends/friends.dart';
import 'package:goose_tap/features/mine/view/mine_screen.dart';
import 'package:goose_tap/features/widgets/bottom_bar_box.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';
import '../exchange/view/exchange_screen.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  final getIt = GetIt.instance;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;
    return Scaffold(
      backgroundColor: Colors.black,
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
          left: 20 * scale,
          right: 20 * scale,
          top: 0,
          bottom: 20 * scale,
        ),
        child: Container(
          height: 70 * scale,
          decoration: BoxDecoration(
            color: Color(0xFF111111),
            borderRadius: BorderRadiusGeometry.circular(10 * scale),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: 10 * scale,
              vertical: 5 * scale,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 0,
                  onTap: () => _onItemTapped(0),
                  screenName: "Mine",
                  screenImage: "assets/bottom_nav_bar_imgs/binance.svg",
                ),
                BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 1,
                  onTap: () => _onItemTapped(1),
                  screenName: "Mine",
                  screenImage: "assets/bottom_nav_bar_imgs/pickaxe.svg",
                ),
                BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 2,
                  onTap: () => _onItemTapped(2),
                  screenName: "Friends",
                  screenImage: "assets/bottom_nav_bar_imgs/friends.svg",
                ),
                BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 3,
                  onTap: () => _onItemTapped(3),
                  screenName: "Earn",
                  screenImage: "assets/bottom_nav_bar_imgs/coins.svg",
                ),
                BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 4,
                  onTap: () => _onItemTapped(4),
                  screenName: "Airdrop",
                  screenImage: "assets/bottom_nav_bar_imgs/goose_coin.svg",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
