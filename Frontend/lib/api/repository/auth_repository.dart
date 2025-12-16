import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final RestClient _client;
  final SharedPreferences _prefs;

  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  AuthRepository(this._client, this._prefs);

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  Future<void> saveTokens(String accessToken, String? refreshToken) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    if (refreshToken != null) {
      await _prefs.setString(_refreshTokenKey, refreshToken);
    }
  }

  Future<void> clearTokens() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
  }

  Future<void> loginTelegram(String initData) async {
    final response = await _client.loginTelegram(TelegramValidateRequest(initData: initData));
    if (response.accessToken != null) {
      await saveTokens(response.accessToken!, response.refreshToken);
    }
  }
}
