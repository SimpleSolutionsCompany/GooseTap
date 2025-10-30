import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/responsiveness/responsiveness.dart';
import 'package:motion/motion.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await initTelegramWebApp();
  setupDependencies();

  FlutterError.onError = (details) {
    log("Flutter error happened: $details");
  };

  final talker = TalkerFlutter.init();
  Bloc.observer = TalkerBlocObserver(talker: talker);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        getIt<Responsiveness>().init(constraints);
        return MaterialApp(
          title: 'GooseTap',
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          //   textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          // ),
          // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

          // home: tg.platform == "android" || tg.platform == "ios"
          //     ? MyBottomBar()
          //     : QrCodeScreen(),
          home: MyBottomBar(),
        );
      },
    );
  }
}
