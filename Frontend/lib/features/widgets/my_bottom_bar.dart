import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '../earn/view/view.dart';
import '../exchange/view/view.dart';
import '../friends/view/view.dart';
import '../games/view/view.dart';
import '../shop/view/view.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: _selectedIndex == 0
          ? ExchangeScreen()
          : _selectedIndex == 1
          ? ShopScreen()
          : _selectedIndex == 2
          ? FriendsScreen()
          : _selectedIndex == 3
          ? EarnScreen()
          : GamesScreen(),

      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 20,
          right: 20,
          top: 0,
          bottom: 20,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFF111111),
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 0,
                  onTap: () => _onItemTapped(0),
                  screenName: "Mine",
                  screenImage: "assets/bottom_nav_bar_imgs/binance.svg",
                ),
                _BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 1,
                  onTap: () => _onItemTapped(1),
                  screenName: "Mine",
                  screenImage: "assets/bottom_nav_bar_imgs/pickaxe.svg",
                ),
                _BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 2,
                  onTap: () => _onItemTapped(2),
                  screenName: "Friends",
                  screenImage: "assets/bottom_nav_bar_imgs/friends.svg",
                ),
                _BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 3,
                  onTap: () => _onItemTapped(3),
                  screenName: "Earn",
                  screenImage: "assets/bottom_nav_bar_imgs/coins.svg",
                ),
                _BottomBarBox(
                  selectedIndex: _selectedIndex,
                  checkIndex: 4,
                  onTap: () => _onItemTapped(4),
                  screenName: "Games",
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

class _BottomBarBox extends StatelessWidget {
  _BottomBarBox({
    super.key,
    required this.selectedIndex,
    required this.checkIndex,
    required this.onTap,
    required this.screenName,
    required this.screenImage,
  });

  final void Function() onTap;
  final int selectedIndex;
  final int checkIndex;
  final String screenName;
  final String screenImage;

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: selectedIndex == 1
                ? Color.fromARGB(121, 32, 32, 32)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(
                    screenImage,

                    color: selectedIndex == checkIndex
                        ? Color(0xFFBB00FF)
                        : Color.fromARGB(255, 94, 94, 94),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  screenName,
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
    );
  }
}
