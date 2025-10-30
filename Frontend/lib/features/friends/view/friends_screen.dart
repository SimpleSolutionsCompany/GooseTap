import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final tg = TelegramWebApp.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(TelegramWebApp.instance.initData.toString());
        },
      ),
      appBar: AppBar(title: Text("Friends Screen")),
      body: Column(
        children: [
          Text("The data must be here"),
          Text("Is Expanded: ${tg.isExpanded}"),
          // current telegram version
          // Text(TelegramWebApp.instance.initData),

          // telegram colors associated with the user's app
          Text(TelegramWebApp.instance.themeParams.toString()),

          // Object containing user details and user validation hash
          Text(TelegramWebApp.instance.initData.toString()),
        ],
      ),
    );
  }
}
