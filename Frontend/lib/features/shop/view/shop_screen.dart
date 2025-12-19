import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goose_tap/features/earn/blocs/game_bloc/game_bloc.dart';
import 'package:goose_tap/features/shop/blocs/get_upgrades_bloc/get_upgrades_bloc.dart';
import 'package:goose_tap/features/shop/shop.dart';
import 'package:goose_tap/features/widgets/widgets.dart';
import 'package:goose_tap/features/exchange/widgets/user_card.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../local/local.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final SharedHelper sharedHelper = SharedHelper();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<GetUpgradesBloc>().add(OnGetUpgradesEvent());
  }

  void switchPanels(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
    log("Selected index is: $selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return MultiBlocListener(
      listeners: [
        BlocListener<GetUpgradesBloc, GetUpgradesState>(
          listener: (context, state) {
            if (state is GetUpgradesSuccess) {
              context.read<GameBloc>().add(GameSyncRequested());
            }
          },
        ),
      ],
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Background Layer
          Positioned.fill(
            child: Container(color: Colors.black),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/exchange_imgs/gradient_bg_purple.png",
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
                errorBuilder: (c, o, s) => Image.asset("assets/gradient_bg_purple2.png", fit: BoxFit.cover),
              ),
            ),
          ),

          // Main Content Layer
          Positioned.fill(
            child: SafeArea(
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, gameState) {
                  if (gameState is GameInitial || gameState is GameLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.purple),
                    );
                  }

                  int balance = 0;
                  double progress = 0.0;
                  int level = 1;
                  int profitPerClick = 1;
                  double profitPerHour = 0.0;
                  
                  if (gameState is GameLoaded) {
                    balance = gameState.balance;
                    progress = gameState.progress;
                    level = gameState.level;
                    profitPerClick = gameState.profitPerClick;
                    profitPerHour = gameState.profitPerHour;
                  }

                  final requiredClicks = _requiredClicksForLevel(level);

                  String username = "Goose Player";
                  String? photoUrl;
                  try {
                    final user = TelegramWebApp.instance.initData?.user;
                    if (user != null) {
                      final dynamic userDyn = user;
                      username = userDyn.username ?? 
                                "${userDyn.first_name ?? ''} ${userDyn.last_name ?? ''}".trim();
                      if (username.isEmpty) username = "Goose Player";
                      photoUrl = userDyn.photo_url;
                    }
                  } catch (e) {
                    log("Safe extraction of user info failed: $e");
                  }

                  return Column(
                    children: [
                      SizedBox(height: height * 0.05),
                      
                      // Info Boxes
                      SizedBox(
                        height: height * 0.08,
                        child: Center(
                          child: InfoBoxes(
                            profitPerTap: profitPerClick,
                            profitPerHour: profitPerHour,
                            coinsToNextLevel: requiredClicks,
                            onTap: () {},
                          ),
                        ),
                      ),
                      
                      // User Card
                      // Current Money Indicator
                      SizedBox(
                        height: height * 0.12,
                        child: MoneyBox(counter: balance),
                      ),
                      
                      // Panel Switcher
                      SizedBox(
                        height: height * 0.06,
                        child: PanelSwitcher(
                          selectedIndex: selectedIndex,
                          onChanged: switchPanels,
                        ),
                      ),
                      
                      SizedBox(height: 16),
                      
                      // Shop Content (GridView)
                      Expanded(
                        child: ShopCard(selectedIndex: selectedIndex),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _requiredClicksForLevel(int level) {
    if (level <= 1) return 100;
    if (level == 2) return 1000;
    if (level == 3) return 3000;
    if (level == 4) return 5000;
    if (level == 5) return 8000;
    if (level == 6) return 15000;
    if (level == 7) return 30000;
    if (level == 8) return 50000;
    return level * 1000;
  }
}
