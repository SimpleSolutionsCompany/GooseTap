import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/jwt_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../services/energy_service.dart';
import 'package:goose_tap/api/repository/auth_repository.dart';
import 'package:goose_tap/api/repository/game_repository.dart';
import 'package:goose_tap/api/repository/upgrades_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<Talker>(Talker());
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<RestClient>(() {
    final apiUrl = dotenv.env["API_URL"];
    final dio = getIt<Dio>()
      ..interceptors.add(JwtInterceptor(dio: getIt<Dio>()));
    return RestClient(dio, baseUrl: apiUrl);
  });

  // Register global energy service (depends on SharedPreferences)
  getIt.registerSingleton<EnergyService>(EnergyService());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(getIt<RestClient>(), getIt<SharedPreferences>()));
  getIt.registerLazySingleton<GameRepository>(
      () => GameRepository(getIt<RestClient>(), getIt<SharedPreferences>()));
  getIt.registerLazySingleton<UpgradesRepository>(
      () => UpgradesRepository(getIt<RestClient>(), getIt<SharedPreferences>()));
}
