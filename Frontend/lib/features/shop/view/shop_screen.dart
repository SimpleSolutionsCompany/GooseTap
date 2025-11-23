import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goose_tap/api/api.dart';
import 'package:goose_tap/api/models/models.dart';
import 'package:goose_tap/di/di.dart';
import 'package:goose_tap/features/shop/blocs/get_upgrades_bloc/get_upgrades_bloc.dart';
import 'package:goose_tap/features/shop/shop.dart';
import 'package:goose_tap/features/widgets/widgets.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String test = "";

  Future<void> fetchUpgrades() async {
    final Dio dio = getIt<Dio>();
    try {
      final resp = await dio.post(
        "https://kirozan-001-site1.qtempurl.com/api/Auth/login-telegram",
        data: {
          'InitData':
              "query_id=AAEyOy1pAAAAADI7LWmVY_Xq&user=%7B%22id%22%3A1764571954%2C%22first_name%22%3A%22Vlad%22%2C%22last_name%22%3A%22Semeniuk%22%2C%22username%22%3A%22Vlad_Semeniuk_18%22%2C%22language_code%22%3A%22uk%22%2C%22allows_write_to_pm%22%3Atrue%2C%22photo_url%22%3A%22https%3A%5C%2F%5C%2Ft.me%5C%2Fi%5C%2Fuserpic%5C%2F320%5C%2FeMlHalTzJIG17A8ONHIdd6yPLhkjN8LzLlUTjAOWYiE.svg%22%7D&auth_date=1763895790&signature=_j8Ydz0cvTaJOWc1VBmnzSD_IwyoSZt6gbi27uJPk6FTQQMfryTlLl3Wf3jl3BBW8qv9-SXNSEWVmscFjMsYAA&hash=98933126139c5da8fe146767c26bd23ac791941b1e62c365eb91888ea88c40e0",
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      final data = resp.data;
      print(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getUp() async {
    final MainUpgradeModel response = await getIt<RestClient>()
        .getAllUpgrades();

    print(response.upgrades[0].name);
  }

  int selectedIndex = 0;

  void switchPanels(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
    log("Selected index is: $selectedIndex");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GetUpgradesBloc>().add(OnGetUpgradesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await fetchUpgrades();
          await getUp();
        },
        child: Icon(Icons.speed),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/gradient_bg_purple2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: height * 0.08,
            child: InfoBoxes(onTap: () {}),
          ),
          Positioned(top: height * 0.17, child: MoneyBox(counter: 1000)),
          Positioned(
            top: height * 0.28,
            child: PanelSwitcher(
              selectedIndex: selectedIndex,
              onChanged: switchPanels,
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ShopCard(selectedIndex: selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
