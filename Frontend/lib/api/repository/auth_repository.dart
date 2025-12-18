import 'dart:developer';

import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class AuthRepository {
  final RestClient _client;
  final SharedPreferences _prefs;

  static const String _accessTokenKey = 'accessToken';

  AuthRepository(this._client, this._prefs);

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  Future<void> saveTokens(String accessToken) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    log("AuthRepository: Access token saved.");
  }

  Future<void> clearTokens() async {
    await _prefs.remove(_accessTokenKey);
    log("AuthRepository: Access token cleared.");
  }

  Future<void> loginTelegram(String initData) async {
    log("AuthRepository: Attempting Telegram login...");
    final response = await _client.loginTelegram(
      TelegramValidateRequest(initDataRaw: initData),
    );
    if (response.accessToken != null) {
      log("AuthRepository: Login successful. Token obtained.");
      await saveTokens(response.accessToken!);
    } else {
      log("AuthRepository: Login response missing accessToken.");
    }
  }

  Future<void> reAuthenticate() async {
    log("AuthRepository: Re-authenticating...");
    final tg = TelegramWebApp.instance;
    final initData = tg.initData.raw;
    if (initData != null && initData.isNotEmpty) {
      await loginTelegram(initData);
    } else {
      log("AuthRepository: Re-authentication failed: initData is null or empty.");
      throw Exception("No initData available for re-authentication");
    }
  }
}
