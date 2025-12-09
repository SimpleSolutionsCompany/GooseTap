import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:goose_tap/utils/visibility_listener_stub.dart';
import '../local/local.dart';

class EnergyService with WidgetsBindingObserver {
  final SharedHelper _sharedHelper = SharedHelper();

  /// Notifies listeners about current energy (0..1000)
  final ValueNotifier<int> energy = ValueNotifier<int>(1000);

  Timer? _timer;
  bool _started = false;

  EnergyService() {
    _initFromStorage();
  }

  void _initFromStorage() {
    int e =
        _sharedHelper.getSavedEnergy() + _sharedHelper.getPassedTimeEnergy();
    if (e >= 1000) e = 1000;
    energy.value = e;
    log('EnergyService initialized with ${energy.value}');
  }

  void start() {
    if (_started) return;
    _started = true;
    _timer?.cancel();
    // register for app lifecycle events so we can save time on pause
    try {
      WidgetsBinding.instance.addObserver(this);
    } catch (_) {}
    // on web, also listen for document visibility changes
    try {
      registerVisibilityCallback(saveLastTime);
    } catch (_) {}
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (energy.value >= 1000) return;
      energy.value++;
      _sharedHelper.saveEnergy(energy.value);
    });
  }

  void stop() {
    _timer?.cancel();
    _started = false;
    try {
      WidgetsBinding.instance.removeObserver(this);
    } catch (_) {}
    try {
      unregisterVisibilityCallback();
    } catch (_) {}
  }

  /// Try to consume `amount` energy. Returns true when successful.
  bool consume(int amount) {
    if (energy.value >= amount) {
      energy.value -= amount;
      _sharedHelper.saveEnergy(energy.value);
      return true;
    }
    return false;
  }

  void saveLastTime() => _sharedHelper.saveLastTime();

  /// Debug helper: simulate that the app was backgrounded [seconds] seconds ago.
  /// Saves an adjusted last-time and re-initializes energy from storage.
  void simulateAwaySeconds(int seconds) {
    try {
      _sharedHelper.saveLastTimeOffset(seconds);
      _initFromStorage();
      // ensure listeners see the new value
      energy.notifyListeners();
    } catch (e) {
      log('[debug] simulateAwaySeconds error: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // when app goes to background/paused, save last time so we can top-up on next start
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      saveLastTime();
    }
    super.didChangeAppLifecycleState(state);
  }

  void dispose() {
    _timer?.cancel();
    try {
      WidgetsBinding.instance.removeObserver(this);
    } catch (_) {}
    try {
      unregisterVisibilityCallback();
    } catch (_) {}
    energy.dispose();
  }
}
