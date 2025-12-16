import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import "package:get_it/get_it.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:goose_tap/features/earn/blocs/game_bloc/game_bloc.dart";
import "package:goose_tap/services/energy_service.dart";

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
      _flyingOnes.add(FlyingOne(key: UniqueKey(), position: position));
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
           if (state is GameLoaded) {
              // Check if level changed to trigger animation?
              // Simple check: if state.level > previous.level?
              // But BlocListener doesn't give previous state easily unless we store it.
              // Logic for level up animation might need refactoring or we assume
              // if we see progress reset it might include level up.
              // For now, let's just make sure UI reflects state.
              // If we want the specific animation popup from `_handleLevelUps`:
              // We could implement `listenWhen`.
           }
        },
        listenWhen: (previous, current) {
           if (previous is GameLoaded && current is GameLoaded) {
              if (current.level > previous.level) {
                 // Trigger Animation
                 _levelUpController?.forward(from: 0.0);
                 setState(() { _showLevelUp = true; });
                 Timer(const Duration(milliseconds: 1400), () {
                    if (mounted) setState(() { _showLevelUp = false; });
                 });
              }
           }
           return true; 
        },
        builder: (context, state) {
          int counter = 0;
          int energy = 0;
          double progress = 0;
          int level = 1;
          int requiredClicks = 100; // Default

          if (state is GameLoaded) {
            counter = state.balance;
            energy = state.energy;
            progress = state.progress;
            level = state.level;
            // We need to know required clicks for display?
            // UserCard expects `requiredClicks`.
            // We can move `_requiredClicksForLevel` to public static or just duplicate/keep helper.
            // Since I removed the helper method from the class (in previous step), I should bring it back OR
            // access it from GameBloc if I made it public static? I made it private in GameBloc.
            // I'll re-add it as a helper here or keep it simple.
            // Let's assume I need to handle `requiredClicks` calculation here.
             if (level == 1) requiredClicks = 100;
             else if (level == 2) requiredClicks = 1000;
             else if (level == 3) requiredClicks = 3000;
             else if (level == 4) requiredClicks = 5000;
             else if (level == 5) requiredClicks = 8000;
             else if (level == 6) requiredClicks = 15000;
             else if (level == 7) requiredClicks = 30000;
             else if (level == 8) requiredClicks = 50000;
             else requiredClicks = level * 1000;
          }

          return Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (stackContext) {
                    return Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/exchange_imgs/gradient_bg_purple.png",
                          ),
                        ),
                        SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.07),
                              Flexible(
                                flex: 2,
                                child: UserCard(
                                  counter: counter,
                                  progress: progress,
                                  level: level,
                                  requiredClicks: requiredClicks,
                                ),
                              ),

                              // Spacer(flex: 1),
                              Flexible(
                                flex: 1,
                                child: Center(child: InfoBoxes(onTap: () {})),
                              ),
                              // Spacer(flex: 1),
                              // SizedBox(height: height * 0.015),
                              Flexible(
                                flex: 3,
                                child: Center(
                                  child: GooseCircle(
                                    counter: counter,
                                    // enabled: _energy > 0,
                                    onTapUp: (details) =>
                                        _onTap(stackContext, details),
                                  ),
                                ),
                              ),
                              // SizedBox(height: height * 0.008),
                              Flexible(flex: 1, child: Energy(energy: energy)),
                            ],
                          ),
                        ),
                        ..._flyingOnes.map(
                          (e) => e.build(stackContext, _removeFlyingOne),
                        ),

                    if (kDebugMode)
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // child: <removed debug info relying on sharedHelper for clarity/safety>
                          child: SizedBox(), 
                        ),
                      ),
                    if (_showLevelUp)
                      Positioned.fill(
                        child: Center(
                          child: ScaleTransition(
                            scale: _levelUpScale ?? AlwaysStoppedAnimation(1.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Level Up!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Level $level', // Using local var from builder
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
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
            ),
          ),
        ],
      );
    },
   ), // Closing BlocConsumer
 );
}
}
