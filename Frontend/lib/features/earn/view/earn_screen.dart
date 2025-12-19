import 'package:flutter/material.dart';

class EarnScreen extends StatelessWidget {
  const EarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // return Scaffold(
    //   appBar: AppBar(title: Text("Earn Screen")),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,

    //     children: [
    //       Bounce(
    //         duration: const Duration(microseconds: 500),
    //         onPressed: () {},
    //         child: Container(),
    //       ),
    //       Center(
    //         child: Motion(
    //           filterQuality: FilterQuality.high,
    //           child: Bounce(
    //             duration: const Duration(milliseconds: 200),
    //             onPressed: () {
    //               print("---------Hello-----------");
    //             },
    //             child: Container(
    //               height: 100,
    //               width: 100,
    //               decoration: BoxDecoration(color: Colors.amber),
    //             ),
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 40),
    //       Wrap(
    //         spacing: 10,
    //         runSpacing: 10,
    //         children: List.generate(8, (index) {
    //           return Container(
    //             width: 100,
    //             height: 50,
    //             color: Colors.blue[(index + 1) * 100],
    //             child: Center(child: Text("Box $index")),
    //           );
    //         }),
    //       ),
    //     ],
    //   ),
    // );
  }
}
