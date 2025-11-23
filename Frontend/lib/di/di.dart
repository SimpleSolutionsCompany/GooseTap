import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/jwt_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<Talker>(Talker());
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<RestClient>(() {
    final apiUrl = dotenv.env["API_URL"];
    final dio = getIt<Dio>()
      ..interceptors.add(
        JwtInterceptor(
          dio: getIt<Dio>(),
          // testInitData:
          //     "query_id=AAEyOy1pAAAAADI7LWmVY_Xq&user=%7B%22id%22%3A1764571954%2C%22first_name%22%3A%22Vlad%22%2C%22last_name%22%3A%22Semeniuk%22%2C%22username%22%3A%22Vlad_Semeniuk_18%22%2C%22language_code%22%3A%22uk%22%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%3A%5C%2F%5C%2Ft.me%5C%2Fi%5C%2Fuserpic%5C%2F320%5C%2FeMlHalTzJIG17A8ONHIdd6yPLhkjN8LzLlUTjAOWYiE.svg%22%7D&auth_date=1763895790&signature=_j8Ydz0cvTaJOWc1VBmnzSD_IwyoSZt6gbi27uJPk6FTQQMfryTlLl3Wf3jl3BBW8qv9-SXNSEWVmscFjMsYAA&hash=98933126139c5da8fe146767c26bd23ac791941b1e62c365eb91888ea88c40e0",
        ),
      );
    return RestClient(dio, baseUrl: apiUrl);
  });
}
