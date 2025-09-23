import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goose_tap/features/mine/widgets/choose_bar.dart';
import 'package:goose_tap/features/mine/widgets/daily_combo_box.dart';
import 'package:goose_tap/features/mine/widgets/shop_card.dart';
import '../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF343639),
      body: Column(
        children: [
          SizedBox(height: 70.h),
          Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 0.8.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(45.r),
                topLeft: Radius.circular(45.r),
              ),
              border: Border(
                top: BorderSide(color: Color(0xFFF9D838), width: 3.5.w),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF9D838).withOpacity(0.4),
                  offset: Offset(0, -35.h),
                  spreadRadius: 5.w,
                  blurRadius: 15.r,
                ),
              ],
              color: Color(0xFF2C2F35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                InfoBoxes(onTap: () {}),
                SizedBox(height: 40.h),
                MoneyBox(),
                SizedBox(height: 10.h),
                WorkingTimeBox(),
                SizedBox(height: 20.h),
                DailyComboBox(),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MainBox(
                        cardImg: "assets/mine_imgs/island.svg",
                        cardName: "Lisesnce Japan",
                      ),
                      MainBox(
                        cardImg: "assets/mine_imgs/bug.svg",
                        cardName: "QA team",
                      ),
                      MainBox(
                        cardImg: "assets/mine_imgs/big_meme.svg",
                        cardName: "Meme coins",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                ChooseBar(),
                Expanded(
                  child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ two cards per row
                      crossAxisSpacing: 12, // spacing between columns
                      mainAxisSpacing: 12, // spacing between rows
                      // childAspectRatio: 117,
                    ),
                    itemBuilder: (context, index) {
                      return ShopCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
