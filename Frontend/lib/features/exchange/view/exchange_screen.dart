import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "../../widgets/widgets.dart";
import "../widgets/widgets.dart";

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  int _counter = 0;
  int _energy = 1000;
  double _progress = 0;

  final List<FlyingOne> _flyingOnes = [];
  final getIt = GetIt.instance;

  void _onTap(BuildContext context, TapUpDetails details) {
    setState(() {
      if (_energy > 0) {
        _counter++;
        _energy--;
        _progress += 0.001;
      }

      final renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.globalToLocal(details.globalPosition);
      _flyingOnes.add(FlyingOne(key: UniqueKey(), position: position));
    });
  }

  void _removeFlyingOne(Key key) {
    setState(() {
      _flyingOnes.removeWhere((e) => e.key == key);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
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
