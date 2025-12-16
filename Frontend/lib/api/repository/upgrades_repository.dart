import 'dart:convert';
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
        final Map<String, dynamic> json = jsonDecode(jsonString);
        // Assuming MainUpgradeModel structure
        final mainModel = MainUpgradeModel.fromJson(json);
        return mainModel.upgrades;
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  Future<void> saveUpgrades(MainUpgradeModel model) async {
    final jsonString = jsonEncode(model.toJson());
    await _prefs.setString(_upgradesKey, jsonString);
  }

  Future<List<UpgradeModel>> getUpgrades() async {
    // Note: existing method is getAllUpgrades which returns MainUpgradeModel
    // MainUpgradeModel presumably has a list of upgrades
    final response = await _client.getAllUpgrades();
    await saveUpgrades(response);
    return response.upgrades;
  }

  Future<void> buyUpgrade(String id) async {
    await _client.buyUpgrade(BuyUpgradeRequest(upgradeId: id));
    // After buying, we might want to re-fetch upgrades or the user state
    // For now, let the caller handle re-fetching if needed.
  }
}
