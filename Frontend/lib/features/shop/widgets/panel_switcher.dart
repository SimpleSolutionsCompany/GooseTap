import 'package:flutter/material.dart';

class PanelSwitcher extends StatelessWidget {
  const PanelSwitcher({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.07; // responsive
    final double radius = size.width * 0.02;

    return Container(
      width: 360,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(96, 47, 47, 47),
        // color: Colors.red,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.015,
          vertical: size.height * 0.008,
        ),
        child: Row(
          children: [
            SwitchBox(
              text: "Upgrades",
              index: 0,
              selectedIndex: selectedIndex,
              onTap: onChanged,
            ),
            SizedBox(width: size.width * 0.015),
            SwitchBox(
              text: "Cards",
              index: 1,
              selectedIndex: selectedIndex,
              onTap: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchBox extends StatelessWidget {
  const SwitchBox({
    super.key,
    required this.selectedIndex,
    required this.index,
    required this.text,
    required this.onTap,
  });

  final int selectedIndex;
  final int index;
  final ValueChanged<int> onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isSelected = selectedIndex == index;
    final double radius = size.width * 0.02;
    final double fontSize = size.width * 0.032; // scales with screen

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(127, 47, 47, 47)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
