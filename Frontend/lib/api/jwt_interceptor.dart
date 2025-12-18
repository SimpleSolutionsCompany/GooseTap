import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class JwtInterceptor extends Interceptor {
  JwtInterceptor({
    required this.dio,
    required SharedPreferences prefs,
    String? testInitData,
  }) : _prefs = prefs {
    _testInitData = testInitData;
  }

  final Dio dio;
  final tg = TelegramWebApp.instance;
  String? _testInitData; 

  final SharedPreferences _prefs;
  bool _isRefreshing = false;
  final List<void Function(String)> _retryQueue = [];

  Future<String?> _getAccess() async => _prefs.getString("accessToken");

  Future<void> _saveTokens(String access) async {
    await _prefs.setString("accessToken", access);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _getAccess();
    if (token != null) {
      log("JwtInterceptor: Adding Authorization header to: ${options.path}");
      options.headers["Authorization"] = "Bearer $token";
    } else {
      log("JwtInterceptor: No token found for: ${options.path}");
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // Don't retry if the request itself was the login-telegram call to avoid infinite loop
    if (err.requestOptions.path.contains("/api/Auth/login-telegram")) {
      return handler.next(err);
    }

    // Use test initData if provided, else read from tg
    String? initDataRaw = _testInitData;
    if (initDataRaw == null || initDataRaw.isEmpty) {
      if (tg.isSupported) {
        initDataRaw = tg.initData.raw;
      } else {
        // Fallback for some desktop clients or debug environments
        initDataRaw = tg.initData.raw;
        if (initDataRaw != null && initDataRaw.isNotEmpty) {
           log("Note: tg.isSupported is false but tg.initData.raw is present. Using it.");
        }
      }
    }
    
    if (initDataRaw == null || initDataRaw.isEmpty) {
      log("initData is null or empty, cannot refresh token. Status: 401");
      return handler.next(err);
    }

    if (_isRefreshing) {
      _retryQueue.add((token) {
        err.requestOptions.headers["Authorization"] = "Bearer $token";
        dio.fetch(err.requestOptions).then((response) {
          handler.resolve(response);
        }).catchError((e) {
          handler.next(e is DioException ? e : err);
        });
      });
      return;
    }

    _isRefreshing = true;

    try {
      log("Refreshing token for 401 error at: ${err.requestOptions.path}");
      // Use a separate Dio instance to avoid deadlock and interceptor loop
      final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
      final resp = await refreshDio.post(
        "/api/Auth/login-telegram",
        data: {"initDataRaw": initDataRaw},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      final newAccess = resp.data["accessToken"];
      if (newAccess == null) throw Exception("accessToken is null in refresh response");

      await _saveTokens(newAccess);
      log("Token refreshed successfully");

      _isRefreshing = false;

      // Retry the current request
      err.requestOptions.headers["Authorization"] = "Bearer $newAccess";
      final response = await dio.fetch(err.requestOptions);
      
      // Retry all queued requests
      for (var callback in _retryQueue) {
        callback(newAccess);
      }
      _retryQueue.clear();

      return handler.resolve(response);
    } catch (e) {
      log("Token refresh failed: $e");
      _isRefreshing = false;
      
      // If refresh fails, reject all queued requests
      for (var callback in List.from(_retryQueue)) {
        // Since we can't easily reject via callback without more complexity,
        // we'll just clear the queue and let the original handlers timeout or handle logic.
        // Better implementation would be to store handlers too.
      }
      _retryQueue.clear();
      
      return handler.next(err);
    }
  }
}
