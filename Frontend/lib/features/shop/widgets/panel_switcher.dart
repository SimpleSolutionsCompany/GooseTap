import 'package:flutter/material.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

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
    final scale = getIt<Responsiveness>().scale;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30 * scale),
      child: Container(
        width: 399 * scale,
        height: 41 * scale,
        decoration: BoxDecoration(
          color: Color.fromARGB(96, 47, 47, 47),
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 5 * scale,
            vertical: 5 * scale,
          ),
          child: Row(
            children: [
              SwitchBox(
                text: "Upgrades",
                index: 0,
                selectedIndex: selectedIndex,
                onTap: onChanged,
              ),
              SizedBox(width: 4 * scale),
              SwitchBox(
                text: "Cards",
                index: 1,
                selectedIndex: selectedIndex,
                onTap: onChanged,
              ),
            ],
          ),
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
    final scale = getIt<Responsiveness>().scale;
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Color.fromARGB(127, 47, 47, 47)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5 * scale),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
