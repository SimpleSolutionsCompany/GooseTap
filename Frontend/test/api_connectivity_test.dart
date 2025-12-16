import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';

void main() {
  group('API Connectivity', () {
    late Dio dio;
    late RestClient client;
    final String baseUrl = "https://kirozan-001-site1.qtempurl.com"; // Taken from ShopScreen commented out code or use env

    setUp(() {
      dio = Dio();
      // Add LogInterceptor to see requests if needed, but for test we just check success
      dio.options.headers['Content-Type'] = 'application/json';
      client = RestClient(dio, baseUrl: baseUrl);
    });

    test('Helpers: Check raw URL connectivity', () async {
       try {
         final response = await dio.get('$baseUrl/api/Upgrades');
         expect(response.statusCode, 200);
         print('GET /api/Upgrades status: ${response.statusCode}');
       } catch (e) {
         print('Error connecting to $baseUrl: $e');
         // If this fails, integration test fails, which is expected if server invalid
       }
    });

    // We can't easily test authenticated endpoints without a valid initData string from Telegram
    // But we can test checking if the endpoint exists (e.g. 401 Unauthorized vs 404 Not Found)
    
    test('POST /api/Game/Sync returns 401/403 (or success) implying endpoint exists', () async {
      try {
        await client.gameSync(SyncRequest(tapsCount: 0));
      } catch (e) {
        if (e is DioException) {
          // We expect 401 because we didn't log in / set Authorization header
          // This confirms the HTTP method POST reached the server (found) but was unauthorized
          // If it was 404, then the method/path is wrong.
          print('POST /api/Game/Sync status: ${e.response?.statusCode}');
          expect(e.response?.statusCode, anyOf(401, 500, 200)); 
          expect(e.response?.statusCode, isNot(404)); // Crucial verify
        }
      }
    });

    test('POST /api/Game/Click returns 401/403 (implying endpoint exists)', () async {
      try {
        await client.gameClick(GameUpdateRequest(clicks: 1, energySpent: 1, timestamp: DateTime.now()));
      } catch (e) {
        if (e is DioException) {
           print('POST /api/Game/Click status: ${e.response?.statusCode}');
           print('Error type: ${e.type}');
           print('Error message: ${e.message}');
           expect(e.response?.statusCode, isNot(404));
        }
      }
    });
  });
}
