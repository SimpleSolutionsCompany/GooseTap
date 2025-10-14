import 'dart:math';

import 'package:flutter/material.dart';

class FlyingOne {
  final Key key;
  final Offset position;

  FlyingOne({required this.key, required this.position});

  Widget build(BuildContext context, Function(Key) onEnd) {
    return _AnimatedFlyingOne(
      key: key,
      startPosition: position,
      onEnd: () => onEnd(key),
    );
  }
}

class _AnimatedFlyingOne extends StatefulWidget {
  final Offset startPosition;
  final VoidCallback onEnd;

  const _AnimatedFlyingOne({
    required super.key,
    required this.startPosition,
    required this.onEnd,
  });

  @override
  State<_AnimatedFlyingOne> createState() => _AnimatedFlyingOneState();
}

class _AnimatedFlyingOneState extends State<_AnimatedFlyingOne>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _moveUp;
  late final Animation<double> _fadeOut;
  late final double _randomXOffset;

  @override
  void initState() {
    super.initState();
    _randomXOffset = (Random().nextDouble() - 0.5) * 80;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _moveUp = Tween<double>(
      begin: 0,
      end: -100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeOut = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().whenComplete(widget.onEnd);
  }

  @override
  void dispose() {
    if (!mounted) return;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.startPosition.dx + _randomXOffset,
          top: widget.startPosition.dy + _moveUp.value,
          child: Opacity(
            opacity: _fadeOut.value,
            child: Text(
              '+1',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.yellow.withOpacity(0.9),
              ),
            ),
          ),
        );
      },
    );
  }
}
