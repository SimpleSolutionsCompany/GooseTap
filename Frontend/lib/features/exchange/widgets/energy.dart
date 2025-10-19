import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';

class Energy extends StatefulWidget {
  const Energy({super.key, required this.energy});

  final int energy;

  @override
  State<Energy> createState() => _EnergyState();
}

class _EnergyState extends State<Energy> {
  final getIt = GetIt.instance;
  int avaliableEnergy = 1000;

  @override
  Widget build(BuildContext context) {
    final scale = getIt<Responsiveness>().scale;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40 * scale,
                height: 40 * scale,
                child: Image.asset("assets/exchange_imgs/energy.png"),
              ),
              Text(
                "${widget.energy}/$avaliableEnergy",
                style: TextStyle(
                  fontSize: 16 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
