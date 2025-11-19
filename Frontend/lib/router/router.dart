// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:goose_tap/features/earn/view/view.dart';
// import 'package:goose_tap/features/exchange/view/view.dart';
// import 'package:goose_tap/features/friends/friends.dart';
// import '../features/games/view/view.dart';
// import '../features/shop/shop.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorExchageKey = GlobalKey<NavigatorState>(
//   debugLabel: "shellExchange",
// );
// final _shellNavigatorShopKey = GlobalKey<NavigatorState>(
//   debugLabel: "shellShop",
// );
// final _shellNavigatorFriendsKey = GlobalKey<NavigatorState>(
//   debugLabel: "shellFriends",
// );
// final _shellNavigatorEarnKey = GlobalKey<NavigatorState>(
//   debugLabel: "shellEarn",
// );
// final _shellNavigatorGamesKey = GlobalKey<NavigatorState>(
//   debugLabel: "shellGames",
// );

// class AppRoutes {
//   static const String exchangeScreen = "/exchange";
//   static const String shopScreen = "/shop";
//   static const String friendsScreen = "/friends";
//   static const String earnScreen = "/earn";
//   static const String gamesScreen = "/games";
// }

// final router = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: AppRoutes.exchangeScreen,
//   routes: [
//     StatefulShellRoute.indexedStack(
//       branches: [
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorExchageKey,
//           routes: [
//             GoRoute(
//               path: AppRoutes.exchangeScreen,
//               builder: (context, state) => ExchangeScreen(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorShopKey,
//           routes: [
//             GoRoute(
//               path: AppRoutes.shopScreen,
//               builder: (context, state) => ShopScreen(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorFriendsKey,
//           routes: [
//             GoRoute(
//               path: AppRoutes.friendsScreen,
//               builder: (context, state) => FriendsScreen(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorEarnKey,
//           routes: [
//             GoRoute(
//               path: AppRoutes.earnScreen,
//               builder: (context, state) => EarnScreen(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorGamesKey,
//           routes: [
//             GoRoute(
//               path: AppRoutes.gamesScreen,
//               builder: (context, state) => GamesScreen(),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
