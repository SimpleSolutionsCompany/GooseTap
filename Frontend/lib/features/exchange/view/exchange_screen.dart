import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:goose_tap/responsiveness/responsiveness.dart";
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
    final scale = getIt<Responsiveness>().scale;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
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
                top: 100 * scale,
                child: UserCard(counter: _counter, progress: _progress),
              ),

              Positioned(
                top: 330 * scale,
                child: InfoBoxes(onTap: () {}),
              ),
              Positioned(
                top: 420 * scale,
                child: GooseCircle(
                  counter: _counter,
                  onTapUp: (details) => _onTap(context, details),
                ),
              ),

              Positioned(
                top: 750 * scale,
                child: Energy(energy: _energy),
              ),
              ..._flyingOnes.map((e) => e.build(context, _removeFlyingOne)),
            ],
          ),
        ],
      ),
    );
  }
}
