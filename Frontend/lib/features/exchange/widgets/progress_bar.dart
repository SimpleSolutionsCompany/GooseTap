import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final int level;
  final int requiredClicks;
  ProgressBar({
    super.key,
    required this.progress,
    required this.level,
    required this.requiredClicks,
  });

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    bool isFull = progress >= 1.0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Level",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                ],
              ),
              Text(
                "${(progress.isNaN || progress.isInfinite ? 0 : (progress * requiredClicks)).floor()}/$requiredClicks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
          child: Container(
            height: 12,
            color: Colors.grey.shade900, // background
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: (progress.isNaN || progress.isInfinite) ? 0.0 : progress.clamp(0.0, 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: isFull ? Radius.zero : Radius.circular(10),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF00E5FF),
                          Color(0xFF8800FF),
                          Color(0xFFBB00FF),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
