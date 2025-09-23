import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Epic",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
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
              Row(
                children: [
                  Text(
                    "Level",
                    style: TextStyle(
                      color: const Color.fromARGB(129, 255, 255, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "0/10",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 9,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF555555), width: 1),
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Color(0xFFADFAA1),
                      Color(0xFFC597CC),
                      Color(0xFF2F39A3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: LinearProgressIndicator(
                  value: 0.9, // progress
                  borderRadius: BorderRadius.circular(25),
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
