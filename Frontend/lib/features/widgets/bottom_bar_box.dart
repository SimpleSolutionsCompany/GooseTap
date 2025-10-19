import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class BottomBarBox extends StatelessWidget {
  BottomBarBox({
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
    final scale = getIt<Responsiveness>().scale;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 60 * scale,
          height: 60 * scale,
          decoration: BoxDecoration(
            color: selectedIndex == 1
                ? Color.fromARGB(121, 32, 32, 32)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: Padding(
            padding: EdgeInsets.all(6 * scale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25 * scale,
                  height: 25 * scale,
                  child: SvgPicture.asset(
                    screenImage,
                    color: selectedIndex == checkIndex
                        ? Color(0xFFBB00FF)
                        : Color.fromARGB(255, 94, 94, 94),
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  screenName,
                  style: TextStyle(
                    color: Color(0xFFD9D9D9),
                    fontSize: 9 * scale,
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
