import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  // final tg = TelegramWebApp.instance;

  AuthStatus _authStatus = AuthStatus.idle;
  String? _accessToken;
  String? _refreshToken;
  String? _expiresAt;
  String? _errorMessage;

  // ✅ Твій бекенд endpoint
  final String _apiUrl =
      'https://kirozan-001-site1.qtempurl.com/api/Auth/login-telegram';

  Future<void> _authenticate() async {
    // ⚠️ ЗМІНЕНО: Отримуємо саме raw рядок, а не toString() об'єкта
    // final initDataRaw = tg.initData?.raw;

    // if (initDataRaw == null || initDataRaw.isEmpty) {
    //   setState(() {
    //     _authStatus = AuthStatus.error;
    //     // ⚠️ ЗМІНЕНО: Уточнено повідомлення
    //     _errorMessage = 'initData.raw відсутній або порожній';
    //   });
    //   return;
    // }

    setState(() {
      _authStatus = AuthStatus.loading;
      _errorMessage = null;
    });

    try {
      // ⚠️ ЗМІНЕНО: Надсилаємо initDataRaw
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'InitData':
              'query_id=AAEyOy1pAAAAADI7LWmVY_Xq&user=%7B%22id%22%3A1764571954%2C%22first_name%22%3A%22Vlad%22%2C%22last_name%22%3A%22Semeniuk%22%2C%22username%22%3A%22Vlad_Semeniuk_18%22%2C%22language_code%22%3A%22uk%22%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%3A%5C%2F%5C%2Ft.me%5C%2Fi%5C%2Fuserpic%5C%2F320%5C%2FeMlHalTzJIG17A8ONHIdd6yPLhkjN8LzLlUTjAOWYiE.svg%22%7D&auth_date=1763895790&signature=_j8Ydz0cvTaJOWc1VBmnzSD_IwyoSZt6gbi27uJPk6FTQQMfryTlLl3Wf3jl3BBW8qv9-SXNSEWVmscFjMsYAA&hash=98933126139c5da8fe146767c26bd23ac791941b1e62c365eb91888ea88c40e0',
        }),
      );

      // 🔍 Для дебагу — виводимо відповідь у консоль
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _authStatus = AuthStatus.success;
          _accessToken = data['accessToken'];
          _refreshToken = data['refreshToken'];
          _expiresAt = data['expiresAt'];
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _authStatus = AuthStatus.error;
          _errorMessage = 'Невалідна підпис Telegram (401)';
        });
      } else {
        final errorData = jsonDecode(response.body);
        setState(() {
          _authStatus = AuthStatus.error;
          _errorMessage =
              errorData['message'] ??
              'Помилка авторизації (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        _authStatus = AuthStatus.error;
        _errorMessage = 'Помилка з\'єднання: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ ЗМІНЕНО: Отримуємо .raw для відображення
    // final initDataRawString = tg.initData?.raw ?? 'initData.raw порожній';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Telegram Auth Test"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ⚠️ ЗМІНЕНО: Копіюємо .raw
          // final dataToCopy = tg.initData?.raw ?? '';
          // if (dataToCopy.isNotEmpty) {
          // await Clipboard.setData(ClipboardData(text: dataToCopy));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ raw initData скопійовано')),
          );
          //   } else {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('⚠️ initData.raw порожній')),
          //     );
          //   }
        },
        child: const Icon(Icons.copy),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "1️⃣ Raw initData:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              // child: SelectableText(
              //   // ⚠️ ЗМІНЕНО: Відображаємо .raw
              //   // initDataRawString,
              //   // style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
              // ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _authStatus == AuthStatus.loading
                  ? null
                  : _authenticate,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getAuthButtonColor(),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_getAuthButtonText()),
            ),
            const SizedBox(height: 16),
            _buildStatusIndicator(),
            if (_authStatus == AuthStatus.success) ...[
              const Divider(),
              Text("Access Token: $_accessToken"),
              Text("Refresh Token: $_refreshToken"),
              Text("Expires At: $_expiresAt"),
            ],
            if (_authStatus == AuthStatus.error)
              Text(
                "❌ ${_errorMessage ?? 'Помилка'}",
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    switch (_authStatus) {
      case AuthStatus.idle:
        return const Text("⏸️ Натисніть кнопку для авторизації");
      case AuthStatus.loading:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text("⏳ Валідація initData..."),
          ],
        );
      case AuthStatus.success:
        return const Text(
          "✅ Авторизація успішна",
          style: TextStyle(color: Colors.green),
        );
      case AuthStatus.error:
        return Text(
          "❌ ${_errorMessage ?? 'Помилка'}",
          style: const TextStyle(color: Colors.red),
        );
    }
  }

  String _getAuthButtonText() {
    switch (_authStatus) {
      case AuthStatus.loading:
        return 'Валідація...';
      case AuthStatus.success:
        return 'Авторизовано ✅';
      case AuthStatus.error:
        return 'Спробувати ще раз';
      default:
        return 'Авторизуватися через Telegram';
    }
  }

  Color _getAuthButtonColor() {
    switch (_authStatus) {
      case AuthStatus.success:
        return Colors.green;
      case AuthStatus.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}

enum AuthStatus { idle, loading, success, error }
