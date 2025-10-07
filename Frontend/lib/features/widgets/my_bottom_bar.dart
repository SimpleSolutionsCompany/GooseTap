import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          left: 20.w,
          right: 20.w,
          top: 0.w,
          bottom: 20.w,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            return Container(
              height: height * 0.08,
              decoration: BoxDecoration(
                color: Color(0xFF111111),
                borderRadius: BorderRadiusGeometry.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(0),
                        child: Container(
                          width: width * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 0
                                ? Color.fromARGB(121, 32, 32, 32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 25.w,
                                    height: 25.h,
                                    child: SvgPicture.asset(
                                      "assets/bottom_nav_bar_imgs/binance.svg",
                                      color: _selectedIndex == 0
                                          ? Color(0xFFBB00FF)
                                          : Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Exchange",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(1),
                        child: Container(
                          width: width * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 1
                                ? Color.fromARGB(121, 32, 32, 32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 25.w,
                                    height: 25.h,
                                    child: SvgPicture.asset(
                                      "assets/bottom_nav_bar_imgs/pickaxe.svg",
                                      // color: Color(0xFFD9D9D9),
                                      color: _selectedIndex == 1
                                          ? Color(0xFFBB00FF)
                                          : Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Mine",
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(2),
                        child: Container(
                          width: width * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 2
                                ? Color.fromARGB(121, 32, 32, 32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 25.w,
                                    height: 25.h,
                                    child: SvgPicture.asset(
                                      "assets/bottom_nav_bar_imgs/friends.svg",
                                      color: _selectedIndex == 2
                                          ? Color(0xFFBB00FF)
                                          : Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Friends",
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(3),
                        child: Container(
                          width: width * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 3
                                ? Color.fromARGB(121, 32, 32, 32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 25.w,
                                    height: 25.h,
                                    child: SvgPicture.asset(
                                      "assets/bottom_nav_bar_imgs/coins.svg",
                                      color: _selectedIndex == 3
                                          ? Color(0xFFBB00FF)
                                          : Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Earn",
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onItemTapped(4),
                        child: Container(
                          width: width * 0.075,
                          height: height * 0.075,
                          decoration: BoxDecoration(
                            color: _selectedIndex == 4
                                ? Color.fromARGB(121, 32, 32, 32)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 25.w,
                                    height: 25.h,
                                    //TODO: update the image
                                    child: Image.asset(
                                      "assets/bottom_nav_bar_imgs/goose_coin.png",
                                    ),
                                    // child: Container(
                                    //   height: 50,
                                    //   width: 50,
                                    //   color: Colors.red,
                                    // ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Airdrop",
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
