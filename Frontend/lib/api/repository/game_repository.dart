import 'dart:convert';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameRepository {
  final RestClient _client;
  final SharedPreferences _prefs;

  static const String _checkpointKey = 'game_checkpoint';

  GameRepository(this._client, this._prefs);

  Future<CheckpointResponse?> getCachedCheckpoint() async {
    final jsonString = _prefs.getString(_checkpointKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return CheckpointResponse.fromJson(json);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> saveCheckpoint(CheckpointResponse checkpoint) async {
    final jsonString = jsonEncode(checkpoint.toJson());
    await _prefs.setString(_checkpointKey, jsonString);
  }

  Future<CheckpointResponse> sync(int tapsCount) async {
    final response = await _client.gameSync(SyncRequest(tapsCount: tapsCount));
    await saveCheckpoint(response);
    return response;
  }

  Future<StringApiResponse> click(int clicks, int energySpent) async {
    // Note: This endpoint returns StringApiResponse, but doesn't return the full checkpoint.
    // The BLoC will optimistically update local state.
    // However, if the backend returns specific data, we might want to parse it.
    // Spec says: "Returns success if the click was processed (queued)."
      timestamp: DateTime.now(),
    ));
  }

  Future<StringApiResponse> buyBooster(BuyBoosterRequest request) async {
    return await _client.buyBooster(request);
  }
}
