import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import "package:get_it/get_it.dart";
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
  // use global EnergyService instead of per-screen timer
  late final EnergyService _energyService;
  VoidCallback? _energyListener;
  AnimationController? _levelUpController;
  Animation<double>? _levelUpScale;
  bool _showLevelUp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _counter = sharedHelper.getSavedMoney();
    _energyService = getIt<EnergyService>();
    _energy = _energyService.energy.value;
    // listen for global updates
    _energyListener = () {
      if (!mounted) return;
      setState(() {
        _energy = _energyService.energy.value;
      });
    };
    _energyService.energy.addListener(_energyListener!);
    _progress = sharedHelper.getSavedProgress();
    _level = sharedHelper.getSavedLevel();

    _levelUpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _levelUpScale = CurvedAnimation(
      parent: _levelUpController!,
      curve: Curves.elasticOut,
    );

    log("Money is: $_counter");
    log("Energy is: $_energy");
    log("Money is: $_progress");

    // EnergyService handles periodic increments globally.
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      sharedHelper.saveLastTime();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _debounce?.cancel();
    if (_energyListener != null) {
      _energyService.energy.removeListener(_energyListener!);
    }
    _levelUpController?.dispose();
    super.dispose();
  }

  void _onTap(BuildContext context, TapUpDetails details) {
    // perform tap effects and progression
    if (_energyService.consume(1)) {
      _counter++;
      // increment progress according to clicks required for current level
      final required = _requiredClicksForLevel(_level);
      _progress += 1.0 / required;

      // possibly level up (handle overflow/carryover)
      if (_progress >= 1.0) {
        _handleLevelUps();
      }
    }

    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.globalToLocal(details.globalPosition);
    setState(() {
      _flyingOnes.add(FlyingOne(key: UniqueKey(), position: position));
    });

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      sharedHelper.saveMoney(_counter);
      sharedHelper.saveProgress(_progress);
      sharedHelper.saveLevel(_level);
      log("The money was saved successfully, counter is: $_counter");
    });
  }

  int _requiredClicksForLevel(int level) {
    // Level 1 requires 100 clicks, level 2 requires 1000 clicks, level 3 requires 3000 clicks
    if (level == 1) return 100;
    if (level == 2) return 1000;
    if (level == 3) return 3000;
    if (level == 4) return 5000;
    if (level == 5) return 8000;
    if (level == 6) return 15000;
    if(level == 7) return 30000;
    if(level == 8) return 50000;
    // for higher levels, scale linearly
    return level * 1000;
  }

  void _handleLevelUps() {
    // allow for carryover if progress exceeded 1.0
    setState(() {
      while (_progress >= 1.0) {
        final overflow = _progress - 1.0;
        _level++;
        _progress = overflow;
        sharedHelper.saveLevel(_level);
        sharedHelper.saveProgress(_progress);
        log('Leveled up to $_level');

        // show animation
        _showLevelUp = true;
        _levelUpController?.forward(from: 0.0);
        // hide after a short delay
        Timer(const Duration(milliseconds: 1400), () {
          if (!mounted) return;
          setState(() {
            _showLevelUp = false;
          });
        });
      }
    });
  }

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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final time = DateTime.now().toUtc().millisecondsSinceEpoch;
      //     int d = ((1765138834447 - 1765138824215) / 1000).floor();

      //     print(d);
      //   },
      //   child: Icon(Icons.add),
      // ),
      backgroundColor: Colors.black,
      body: Column(
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
                              counter: _counter,
                              progress: _progress,
                              level: _level,
                              requiredClicks: _requiredClicksForLevel(_level),
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
                                counter: _counter,
                                // enabled: _energy > 0,
                                onTapUp: (details) =>
                                    _onTap(stackContext, details),
                              ),
                            ),
                          ),
                          // SizedBox(height: height * 0.008),
                          Flexible(flex: 1, child: Energy(energy: _energy)),
                        ],
                      ),
                    ),

                    // Positioned(
                    //   top: height * 0.10,
                    //   child: UserCard(counter: _counter, progress: _progress),
                    // ),
                    // Positioned(
                    //   top: height * 0.36,
                    //   child: InfoBoxes(onTap: () {}),
                    // ),
                    // Positioned(
                    //   top: height * 0.45,
                    //   child: GooseCircle(
                    //     counter: _counter,
                    //     onTapUp: (details) => _onTap(stackContext, details),
                    //   ),
                    //   // child: TestCircle(),
                    // ),
                    // Positioned(
                    //   top: height * 0.84,
                    //   child: Energy(energy: _energy),
                    // ),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Builder(
                                builder: (_) {
                                  final millis = sharedHelper
                                      .getLastSavedTimeMillis();
                                  final label = millis == 0
                                      ? 'none'
                                      : DateTime.fromMillisecondsSinceEpoch(
                                          millis,
                                        ).toUtc().toIso8601String();
                                  return Text(
                                    'lastSaved: $label',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _energyService.simulateAwaySeconds(10);
                                      setState(() {
                                        _energy = _energyService.energy.value;
                                      });
                                    },
                                    child: Text(
                                      'Sim 10s',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _energyService.simulateAwaySeconds(60);
                                      setState(() {
                                        _energy = _energyService.energy.value;
                                      });
                                    },
                                    child: Text(
                                      'Sim 60s',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _energyService.simulateAwaySeconds(3600);
                                      setState(() {
                                        _energy = _energyService.energy.value;
                                      });
                                    },
                                    child: Text(
                                      'Sim 1h',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                    'Level $_level',
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
      ),
    );
  }
}
