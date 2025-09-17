import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoBoxes extends StatelessWidget {
  final void Function()? onTap;
  const InfoBoxes({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFF32363C),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  "Earn per tap",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF79841),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/little_dollar_coin.svg"),
                    const SizedBox(width: 3),
                    Text(
                      "+12",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFF32363C),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  "Earn per tap",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6F72E2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 3),
                    Text(
                      "10M",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFF32363C),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  "Earn per tap",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF84CB69),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/little_dollar_coin.svg"),
                    const SizedBox(width: 3),
                    Text(
                      "+678.3K",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: onTap,
                      child: SvgPicture.asset("assets/info.svg"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
