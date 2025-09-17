import 'package:flutter/material.dart';

class MineScreen extends StatelessWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop Screen")),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 300, height: 300, color: Colors.red),
            Center(
              child: Container(width: 200, height: 200, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
