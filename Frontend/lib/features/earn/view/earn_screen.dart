import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:motion/motion.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Earn Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Bounce(
            duration: const Duration(microseconds: 500),
            onPressed: () {},
            child: Container(),
          ),
          Center(
            child: Motion(
              filterQuality: FilterQuality.high,
              child: Bounce(
                duration: const Duration(milliseconds: 200),
                onPressed: () {
                  print("---------Hello-----------");
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Expanded(
          //   child: GridView.builder(
          //     itemCount: 20,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //     ),
          //     itemBuilder: (context, index) {
          //       return AspectRatio(
          //         aspectRatio: 16 / 9,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),

          //               gradient: LinearGradient(
          //                 colors: [Colors.redAccent, Colors.lightBlue],
          //                 transform: GradientRotation(pi / 4),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          // Row(
          //   children: [
          //     Expanded(child: Container(color: Colors.red)),
          //     Flexible(child: Container(width: 100, color: Colors.green)),
          //     Expanded(flex: 2, child: Container(color: Colors.blue)),
          //   ],
          // ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(8, (index) {
              return Container(
                width: 100,
                height: 50,
                color: Colors.blue[(index + 1) * 100],
                child: Center(child: Text("Box $index")),
              );
            }),
          ),
        ],
      ),
    );
  }
}
