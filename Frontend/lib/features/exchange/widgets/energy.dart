import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Energy extends StatefulWidget {
  const Energy({super.key, required this.energy, this.maxEnergy = 1000});

  final int energy;
  final int maxEnergy;

  @override
  State<Energy> createState() => _EnergyState();
}

class _EnergyState extends State<Energy> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset("assets/exchange_imgs/energy.png"),
              ),
              Text(
                "${widget.energy}/${widget.maxEnergy}",
                style: TextStyle(
                  fontSize: 16,
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
