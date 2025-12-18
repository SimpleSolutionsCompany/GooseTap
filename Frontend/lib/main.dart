import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/services/energy_service.dart';
import 'package:goose_tap/api/repository/auth_repository.dart';
import 'package:goose_tap/api/repository/game_repository.dart';
import 'package:goose_tap/api/repository/upgrades_repository.dart';
import 'package:goose_tap/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:goose_tap/features/earn/blocs/game_bloc/game_bloc.dart';
import 'package:goose_tap/features/shop/blocs/get_upgrades_bloc/get_upgrades_bloc.dart';
import 'package:goose_tap/theme/theme.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'features/widgets/widgets.dart';

Future<void> initTelegramWebApp() async {
  try {
    final tg = TelegramWebApp.instance;

    if (tg.isSupported) {
      try {
        tg.requestFullscreen();
        tg.lockOrientation();
      } catch (e) {
        log("Telegram API failed: ${e.toString()}");
      }
    } else {
      log(
        "Telegram web app is not supported. Skipping fullscreen request and lockOrientaion",
      );
    }
  } catch (outerError) {
    log("Error is: ${outerError.toString()}");
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    // TelegramWebApp.instance.ready();
    await initTelegramWebApp();
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      log("Failed to load .env: $e");
      // Fallback or just continue, maybe API_URL is null and will crash later but at least app starts
    }
    await setupDependencies();

    // start global energy ticker
    getIt<EnergyService>().start();

    FlutterError.onError = (details) {
      log("Flutter error happened: $details");
    };

    final talker = TalkerFlutter.init();
    Bloc.observer = TalkerBlocObserver(talker: talker);

    runApp(const MyApp());
  } catch (e, stack) {
    log("Initialization failed: $e", stackTrace: stack);
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Init Failed: $e", textDirection: TextDirection.ltr)),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = AuthBloc(authRepository: getIt<AuthRepository>());
        // Trigger login if we have initData from TelegramWebApp
        if (TelegramWebApp.instance.initData?.raw != null &&
            TelegramWebApp.instance.initData!.raw!.isNotEmpty) {
          bloc.add(AuthLoginTelegramRequested(
              TelegramWebApp.instance.initData!.raw!));
        } else {
          bloc.add(AuthCheckRequested());
        }
        return bloc;
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GetUpgradesBloc(
                    upgradesRepository: getIt<UpgradesRepository>(),
                  )..add(OnGetUpgradesEvent()),
                ),
                BlocProvider(
                  create: (context) => GameBloc(
                    gameRepository: getIt<GameRepository>(),
                  )..add(GameStarted()),
                ),
              ],
              child: MaterialApp(
                title: 'GooseTap',
                debugShowCheckedModeBanner: false,
                theme: myTheme,
                home: MyBottomBar(),
              ),
            );
          }

          if (state is AuthFailure) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: myTheme,
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Authentication Failed",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (TelegramWebApp.instance.initData?.raw != null) {
                            context.read<AuthBloc>().add(
                                AuthLoginTelegramRequested(
                                    TelegramWebApp.instance.initData!.raw!));
                          } else {
                            context.read<AuthBloc>().add(AuthCheckRequested());
                          }
                        },
                        child: Text("Retry"),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          // AuthInitial, AuthLoading, or AuthUnauthenticated
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: myTheme,
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
