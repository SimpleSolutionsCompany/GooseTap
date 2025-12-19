import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import "package:get_it/get_it.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:goose_tap/features/earn/blocs/game_bloc/game_bloc.dart";
import "package:goose_tap/services/energy_service.dart";
import 'package:telegram_web_app/telegram_web_app.dart';

import "../../../local/local.dart";
import "../../widgets/widgets.dart";
import "../widgets/widgets.dart";

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  int _counter = 0;
  int _energy = 1000;
  double _progress = 0;
  int _level = 1;

  final List<FlyingOne> _flyingOnes = [];
  final getIt = GetIt.instance;
  SharedHelper sharedHelper = SharedHelper();

  Timer? _debounce;
  // Global energy service usage removed from here as we use Bloc
  // late final EnergyService _energyService;
  // VoidCallback? _energyListener;
  AnimationController? _levelUpController;
  Animation<double>? _levelUpScale;
  bool _showLevelUp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Animation setup
    _levelUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _levelUpScale = CurvedAnimation(
      parent: _levelUpController!,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // BLoC handles saving/syncing, we can possibly trigger forced sync here if needed
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _levelUpController?.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context, TapUpDetails details) {
    // 1. Dispatch event to BLoC
    context.read<GameBloc>().add(GameClicked());

    // 2. Flying animation (Local UI effect)
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(details.globalPosition);
    setState(() {
      final state = context.read<GameBloc>().state;
      int profit = 1;
      if (state is GameLoaded) {
        profit = state.profitPerClick;
      }
      _flyingOnes.add(FlyingOne(key: UniqueKey(), position: position, value: profit));
    });
  }

  // Level up listener logic can be moved to BlocListener if we want side effects
  // But for now, simple UI updates via BlocBuilder is cleaner.
  // The animation trigger (_showLevelUp) needs to listen to state changes.

  void _removeFlyingOne(Key key) {
    if (!mounted) return;
    setState(() {
      _flyingOnes.removeWhere((e) => e.key == key);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Game Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is GameInitial || state is GameLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        }

        int counter = 0;
        int energy = 0;
        double progress = 0.0;
        int level = 1;
        int profitPerClick = 1;
        double profitPerHour = 0.0;
        int requiredClicks = 100;

        if (state is GameLoaded) {
          counter = state.balance;
          energy = state.energy;
          progress = state.progress;
          level = state.level;
          profitPerClick = state.profitPerClick;
          profitPerHour = state.profitPerHour;
          requiredClicks = _requiredClicksForLevel(level);
        }

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

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Background Layer
            Positioned.fill(
              child: Container(color: Colors.black),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/exchange_imgs/gradient_bg_purple.png",
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.contain,
              ),
            ),

            // Main Content Layer
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    
                    // User Card
                    Flexible(
                      flex: 4,
                      child: UserCard(
                        counter: counter,
                        progress: progress,
                        level: level,
                        requiredClicks: requiredClicks,
                        username: username,
                        photoUrl: photoUrl,
                      ),
                    ),

                    // Info Boxes
                    Flexible(
                      flex: 2,
                      child: Center(
                        child: InfoBoxes(
                          profitPerTap: profitPerClick,
                          profitPerHour: profitPerHour,
                          coinsToNextLevel: requiredClicks,
                          onTap: () {},
                        ),
                      ),
                    ),

                    // Goose Circle
                    Flexible(
                      flex: 5,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: GooseCircle(
                            counter: counter,
                            onTapUp: (details) => _onTap(context, details),
                          ),
                        ),
                      ),
                    ),

                    // Energy
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Energy(energy: energy),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Flying Ones Layer
            ..._flyingOnes.map(
              (e) => e.build(context, _removeFlyingOne),
            ),

            // Level Up Animation overlay
            if (_showLevelUp)
              Positioned.fill(
                child: Center(
                  child: ScaleTransition(
                    scale: _levelUpScale ?? AlwaysStoppedAnimation(1.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Level Up!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Level $level',
                            style: const TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
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
