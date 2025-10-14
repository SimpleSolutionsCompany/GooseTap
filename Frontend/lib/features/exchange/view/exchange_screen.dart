import "package:flutter/material.dart";
import "package:flutter_bounce/flutter_bounce.dart";
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

  void _onTap(BuildContext context, TapUpDetails details) {
    setState(() {
      _counter++;
      _energy--;
      _progress += 0.001;
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
    return Scaffold(
      backgroundColor: Colors.black,

      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/exchange_imgs/gradient_bg_purple.png",
                    ),
                  ),

                  Positioned(
                    top: height * 0.12,
                    child: UserCard(counter: _counter, progress: _progress),
                  ),

                  Positioned(
                    top: height * 0.38,
                    child: InfoBoxes(onTap: () {}),
                  ),
                  Positioned(
                    top: height * 0.50,
                    child: GooseCircle(
                      counter: _counter,
                      onTapUp: (details) => _onTap(context, details),
                    ),
                  ),

                  Positioned(
                    top: height * 0.9,
                    child: Energy(energy: _energy),
                  ),
                  ..._flyingOnes.map((e) => e.build(context, _removeFlyingOne)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
