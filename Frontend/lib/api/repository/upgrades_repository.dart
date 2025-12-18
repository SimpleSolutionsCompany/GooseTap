import 'dart:convert';
import 'dart:developer';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpgradesRepository {
  final RestClient _client;
  final SharedPreferences _prefs;

  static const String _upgradesKey = 'upgrades_list';

  UpgradesRepository(this._client, this._prefs);

  Future<List<UpgradeModel>> getCachedUpgrades() async {
    final jsonString = _prefs.getString(_upgradesKey);
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((e) => UpgradeModel.fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        log("Error decoding cached upgrades: $e");
        return [];
      }
    }
    return [];
  }

  Future<void> saveUpgrades(List<UpgradeModel> upgrades) async {
    final jsonString = jsonEncode(upgrades.map((e) => e.toJson()).toList());
    await _prefs.setString(_upgradesKey, jsonString);
  }

  Future<List<UpgradeModel>> getUpgrades() async {
    log("UpgradesRepository: Fetching upgrades...");
    final upgrades = await _client.getAllUpgrades();
    log("UpgradesRepository: Fetched ${upgrades.length} upgrades.");
    await saveUpgrades(upgrades);
    return upgrades;
  }

  Future<BuyUpgradeResponse> buyUpgrade(String id) async {
    log("UpgradesRepository: Buying upgrade $id...");
    final response = await _client.buyUpgrade(id);
    log("UpgradesRepository: Buy upgrade response: success=${response.success}, message=${response.message}");
    return response;
  }
}
