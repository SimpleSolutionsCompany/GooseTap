import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "../../widgets/widgets.dart";
import "../widgets/widgets.dart";

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF2C2F35),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UpperInfo(),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(45),
                topLeft: Radius.circular(45),
              ),
              border: Border(
                top: BorderSide(color: Color(0xFFF9D838), width: 3.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF9D838).withOpacity(0.4),
                  offset: Offset(0, -35),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
              color: Color(0xFF2C2F35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                InfoBoxes(onTap: () {}),
                MoneyBox(),
                SizedBox(height: 10.h),
                const ProgressBar(),
                SizedBox(height: 30.h),
                GooseCircle(onTap: () {}),
                SizedBox(height: 30.h),
                Energy(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
