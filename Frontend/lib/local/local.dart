import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../di/di.dart';

class SharedHelper {
  final prefs = getIt<SharedPreferences>();

  static const _moneyStorage = "money_storage";
  static const _energyStorage = "energy_storage";
  static const _progressStorage = "progress_storage";
  static const _levelStorage = "level_storage";
  static const _pastTimeCounter = "past_time_counter";

  void saveMoney(int amount) async {
    await prefs.setInt(_moneyStorage, amount);
  }

  int getSavedMoney() {
    int? money = prefs.getInt(_moneyStorage);
    return money ?? 0;
  }

  void saveEnergy(int energyAmount) async {
    await prefs.setInt(_energyStorage, energyAmount);
  }

  int getSavedEnergy() {
    int? energy = prefs.getInt(_energyStorage);
    return energy ?? 1000;
  }

  void saveProgress(double amount) async {
    await prefs.setDouble(_progressStorage, amount);
  }

  double getSavedProgress() {
    double? progress = prefs.getDouble(_progressStorage);
    return progress ?? 0;
  }

  void saveLevel(int level) async {
    await prefs.setInt(_levelStorage, level);
  }

  int getSavedLevel() {
    int? level = prefs.getInt(_levelStorage);
    return level ?? 1;
  }

  void saveLastTime() {
    prefs.setInt(
      _pastTimeCounter,
      DateTime.now().toUtc().millisecondsSinceEpoch,
    );
    log("saved time is: ${DateTime.now().toUtc().millisecondsSinceEpoch}");
  }

  /// Debug helper: set the saved-last-time to now minus [secondsAgo].
  /// If secondsAgo is 0, it's equivalent to `saveLastTime()`.
  void saveLastTimeOffset(int secondsAgo) async {
    final millis =
        DateTime.now().toUtc().millisecondsSinceEpoch - (secondsAgo * 1000);
    await prefs.setInt(_pastTimeCounter, millis);
    log("[debug] saved time offset (secondsAgo=$secondsAgo) is: $millis");
  }

  /// Returns the raw saved last-time milliseconds since epoch, or 0 if not set.
  int getLastSavedTimeMillis() {
    return prefs.getInt(_pastTimeCounter) ?? 0;
  }

  int getPassedTimeEnergy() {
    int lastTime = prefs.getInt(_pastTimeCounter) ?? 0;
    log("last time is: $lastTime");

    if (lastTime == 0) {
      log("Passed time is zero");
      return 0;
    }

    log("last time is: $lastTime");
    int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    log("current time is currentTime $currentTime");
    int addedEnergy = ((currentTime - lastTime) / 1000).floor();
    log("added energy is: $addedEnergy");

    return addedEnergy;
  }
}
