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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final tg = TelegramWebApp.instance;
          Clipboard.setData(ClipboardData(text: tg.initData.raw));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetUpgradesBloc, GetUpgradesState>(
            listener: (context, state) {
              if (state is GetUpgradesSuccess) {
                 // Trigger game sync to update balance after purchase? 
                 // Or we assume GameBloc is already updated if repository handles it?
                 // Actually Gamerepo handles click/sync. Use specific method if needed.
                 // For now let's just trigger sync.
                 context.read<GameBloc>().add(GameSyncRequested());
              }
            },
          ),
        ],
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/exchange_imgs/gradient_bg_purple.png",
                  fit: BoxFit.cover,
                  errorBuilder: (c, o, s) => Image.asset("assets/gradient_bg_purple2.png", fit: BoxFit.cover),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: height * 0.1),
                  Flexible(flex: 1, child: InfoBoxes(onTap: () {})),
                  Spacer(flex: 1),
                  Flexible(
                    flex: 2,
                    child: BlocBuilder<GameBloc, GameState>(
                      builder: (context, state) {
                        int balance = 0;
                        double progress = 0;
                        int level = 1;
                        if (state is GameLoaded) {
                          balance = state.balance;
                          progress = state.progress;
                          level = state.level;
                        }
                        
                        int requiredClicks = 100;
                        if (level == 1) requiredClicks = 100;
                        else if (level == 2) requiredClicks = 1000;
                        else if (level == 3) requiredClicks = 3000;
                        else if (level == 4) requiredClicks = 5000;
                        else if (level == 5) requiredClicks = 8000;
                        else if (level == 6) requiredClicks = 15000;
                        else if (level == 7) requiredClicks = 30000;
                        else if (level == 8) requiredClicks = 50000;
                        else requiredClicks = level * 1000;

                        return UserCard(
                          counter: balance,
                          progress: progress,
                          level: level,
                          requiredClicks: requiredClicks,
                          username: TelegramWebApp.instance.initData?.user?.username ?? 
                                   "${(TelegramWebApp.instance.initData?.user as dynamic)?.first_name ?? ''} ${(TelegramWebApp.instance.initData?.user as dynamic)?.last_name ?? ''}".trim(),
                          photoUrl: (TelegramWebApp.instance.initData?.user as dynamic)?.photo_url,
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 1),
                  Flexible(
                    flex: 1,
                    child: PanelSwitcher(
                      selectedIndex: selectedIndex,
                      onChanged: switchPanels,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Flexible(
                    flex: 8,
                    child: ShopCard(selectedIndex: selectedIndex),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
