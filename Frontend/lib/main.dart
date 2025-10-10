import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
import 'features/widgets/widgets.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final tg = TelegramWebApp.instance;
  // tg.requestFullscreen();
  ////////////
  // tg.lockOrientation();

  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };

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
        // theme: TelegramThemeUtil.getTheme(TelegramWebApp.instance),

        // home: tg.platform == "android" || tg.platform == "ios"
        //     ? MyBottomBar()
        //     : QrCodeScreen(),
        home: MyBottomBar(),
      ),
    );
  }
}
