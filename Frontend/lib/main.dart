@JS()
library telegram_fullscreen;

import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'features/widgets/widgets.dart';

// Підключаємо функції з index.html
@JS('expandTelegramApp')
external void expandTelegramApp();

@JS('goFullscreen')
external void goFullscreen();

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  try {
    if (TelegramWebApp.instance.isSupported) {
      TelegramWebApp.instance.ready();
      Future.delayed(
        const Duration(seconds: 1),
        TelegramWebApp.instance.expand,
      );
      print("Telegram Web App is approved");
    }
  } catch (e) {
    print("Error happened in Flutter while loading Telegram $e");
    // add delay for 'Telegram seldom not loading' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }

  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };

  expandTelegramApp();

  // Визначаємо, чи це мобільний пристрій
  // final userAgent = html.window.navigator.userAgent.toLowerCase();
  // final isMobile = userAgent.contains('iphone');
  // userAgent.contains('android');
  // userAgent.contains('ipad') || userAgent.contains('mobile');

  // if (isMobile) {
  //   js.context.callMethod('expandTelegramApp');
  // } else {
  //   debugPrint("Desktop mode — not expanding.");
  // }

  final talker = TalkerFlutter.init();
  Bloc.observer = TalkerBlocObserver(talker: talker);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (context, child) => MaterialApp(
        title: 'GooseTap',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        //   textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        // ),
        theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

        home: MyBottomBar(),
      ),
    );
  }
}
