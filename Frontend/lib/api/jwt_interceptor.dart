import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class JwtInterceptor extends Interceptor {
  JwtInterceptor({required this.dio, String? testInitData}) {
    _initPrefs();
    _testInitData = testInitData;
  }

  final Dio dio;
  final tg = TelegramWebApp.instance;
  String? _testInitData; // <--- new field for testing

  late SharedPreferences _prefs;
  bool _isRefreshing = false;
  final List<Completer<Response>> _retryQueue = [];

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<String?> _getAccess() async => _prefs.getString("accessToken");
  Future<String?> _getRefresh() async => _prefs.getString("refreshToken");

  Future<void> _saveTokens(String access, String refresh) async {
    await _prefs.setString("accessToken", access);
    await _prefs.setString("refreshToken", refresh);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getAccess();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Use test initData if provided, else read from tg
    final initDataRaw = _testInitData ?? tg.initData?.raw;
    if (initDataRaw == null) {
      log("initData is null, skipping token refresh");
      return handler.next(err);
    }

    if (_isRefreshing) {
      final completer = Completer<Response>();
      _retryQueue.add(completer);
      return completer.future.then(handler.resolve).catchError(handler.reject);
    }

    _isRefreshing = true;

    try {
      final resp = await dio.post(
        "https://goosetap-001-site1.anytempurl.com/api/Auth/login-telegram",
        data: {"InitData": initDataRaw},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      final newAccess = resp.data["accessToken"];
      final newRefresh = resp.data["refreshToken"];

      await _saveTokens(newAccess, newRefresh);

      err.requestOptions.headers["Authorization"] = "Bearer $newAccess";
      final newResponse = await dio.fetch(err.requestOptions);

      for (var completer in _retryQueue) {
        try {
          err.requestOptions.headers["Authorization"] = "Bearer $newAccess";
          final queuedResp = await dio.fetch(err.requestOptions);
          completer.complete(queuedResp);
        } catch (e) {
          completer.completeError(e);
        }
      }

      _retryQueue.clear();
      _isRefreshing = false;
      return handler.resolve(newResponse);
    } catch (e) {
      _isRefreshing = false;
      for (var completer in _retryQueue) {
        completer.completeError(e);
      }
      _retryQueue.clear();
      return handler.next(err);
    }
  }
}
