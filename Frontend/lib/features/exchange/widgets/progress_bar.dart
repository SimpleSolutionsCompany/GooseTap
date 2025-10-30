import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  ProgressBar({super.key, required this.progress});

  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    bool isFull = progress >= 1.0;
    final scale = getIt<Responsiveness>().scale;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Level",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                    size: 15 * scale,
                  ),
                ],
              ),
              Text(
                "1/10",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8 * scale),
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(13 * scale),
            bottomRight: Radius.circular(13 * scale),
          ),
          child: Container(
            height: 12 * scale,
            color: Colors.grey.shade900, // background
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10 * scale),
                    bottomRight: Radius.circular(10 * scale),
                    topRight: isFull
                        ? Radius.zero
                        : Radius.circular(10 * scale),
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
