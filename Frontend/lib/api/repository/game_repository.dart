import 'dart:convert';
import 'dart:developer';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameRepository {
  final RestClient _client;
  final SharedPreferences _prefs;

  static const String _checkpointKey = 'game_checkpoint';

  DateTime? _lastSyncTime;
  static const Duration _syncThrottle = Duration(seconds: 3);

  GameRepository(this._client, this._prefs);

  Future<ClickResponse?> getCachedCheckpoint() async {
    final jsonString = _prefs.getString(_checkpointKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return ClickResponse.fromJson(json);
      } catch (e) {
        log("Error decoding cached checkpoint: $e");
        return null;
      }
    }
    return null;
  }

  Future<void> saveCheckpoint(ClickResponse checkpoint) async {
    final jsonString = jsonEncode(checkpoint.toJson());
    await _prefs.setString(_checkpointKey, jsonString);
  }

  Future<ClickResponse> sync({int clicks = 0, int? level, double? progress}) async {
    final now = DateTime.now();
    // Only throttle if no clicks are being sent. 
    // If there ARE clicks, we want to send them immediately (or at least not block them here).
    if (clicks == 0 && _lastSyncTime != null && now.difference(_lastSyncTime!) < _syncThrottle) {
      log("GameRepository: Sync throttled. Returning cached state.");
      final cached = await getCachedCheckpoint();
      if (cached != null) return cached;
    }

    log("GameRepository: Syncing game state (clicks=$clicks)...");
    _lastSyncTime = now;
    
    try {
      final response = await _client.gameSync(SyncRequest(clickCount: clicks));
      log("GameRepository: Sync successful. Balance: ${response.balance}");
      
      // Merge local fields (level, progress) which aren't on the backend
      final cached = await getCachedCheckpoint();
      final mergedResponse = ClickResponse(
        balance: response.balance,
        currentEnergy: response.currentEnergy,
        profitPerClick: response.profitPerClick,
        energyRestorePerSecond: response.energyRestorePerSecond,
        maxEnergy: response.maxEnergy,
        level: level ?? cached?.level ?? 1,
        progress: progress ?? cached?.progress ?? 0.0,
      );

      await saveCheckpoint(mergedResponse);
      return mergedResponse;
    } catch (e) {
      log("GameRepository: Sync failed: $e");
      rethrow;
    }
  }

  Future<StringApiResponse> buyBooster(BuyBoosterRequest request) async {
    log("GameRepository: Buying booster...");
    final response = await _client.buyBooster(request);
    log("GameRepository: Booster purchase response: ${response.message}");
    return response;
  }
}
