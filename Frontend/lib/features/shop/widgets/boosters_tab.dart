import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:goose_tap/features/earn/blocs/game_bloc/game_bloc.dart';

class BoostersTab extends StatelessWidget {
  const BoostersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is! GameLoaded) {
          return Center(child: CircularProgressIndicator());
        }

        final boosters = [
          _BoosterItem(
            type: "Multitap",
            name: "Multitap",
            description: "Increase coins per tap",
            level: state.multitapLevel,
            baseCost: 500,
            imagePath: "assets/shop_imgs/bench_press.png",
            onBuy: () {
               context.read<GameBloc>().add(BoosterPurchased("Multitap"));
            },
            balance: state.balance,
          ),
          _BoosterItem(
            type: "EnergyLimit",
            name: "Energy Limit",
            description: "Increase max energy (+500)",
            level: state.energyLimitLevel,
            baseCost: 500,
            imagePath: "assets/shop_imgs/winter_arc.png",
             onBuy: () {
               context.read<GameBloc>().add(BoosterPurchased("EnergyLimit"));
            },
            balance: state.balance,
          ),
          _BoosterItem(
            type: "RechargingSpeed",
            name: "Recharging Speed",
            description: "Recover energy faster",
            level: state.rechargeSpeedLevel,
            baseCost: 2000,
             imagePath: "assets/shop_imgs/tick_tok_bun.png",
             onBuy: () {
               context.read<GameBloc>().add(BoosterPurchased("RechargingSpeed"));
            },
            balance: state.balance,
          ),
        ];

        return GridView.builder(
          padding: EdgeInsets.all(size.width * 0.04),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width < 450 ? 2 : 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: boosters.length,
          itemBuilder: (context, index) {
            final item = boosters[index];
            return GestureDetector(
              onTap: () {
                 if (item.canAfford) {
                    item.onBuy();
                 }
              },
              child: _BoosterCard(item: item),
            );
          },
        );
      },
    );
  }
}

class _BoosterItem {
  final String type;
  final String name;
  final String description;
  final int level;
  final int baseCost;
  final String imagePath;
  final VoidCallback onBuy;
  final int balance;

  _BoosterItem({
    required this.type,
    required this.name,
    required this.description,
    required this.level,
    required this.baseCost,
    required this.imagePath,
    required this.onBuy,
    required this.balance,
  });

  int get cost => baseCost * pow(2, level - 1).toInt();
  bool get canAfford => balance >= cost;
}

class _BoosterCard extends StatelessWidget {
  final _BoosterItem item;

  const _BoosterCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cost = item.cost;
    final canAfford = item.canAfford;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.035),
        color: Color.fromARGB(67, 47, 47, 47),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(
            height: size.width * 0.1,
            width: size.width * 0.1,
            child: Image.asset(item.imagePath),
          ),
          SizedBox(height: 5),
          Text(
            item.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
           Text(
            "Lvl ${item.level}",
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.03,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.04,
                child: Image.asset("assets/exchange_imgs/coin.png"),
              ),
              SizedBox(width: 5),
              Text(
                "$cost",
                style: TextStyle(
                  color: canAfford ? Colors.white : Colors.red,
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
