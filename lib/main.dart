import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:src/utils/constants.dart';
import './ui/ExchangeCurrencies/index.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: (BuildContext context, GoRouterState state) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage(BACKGROUND_IMAGE_PATH),
                      fit: BoxFit.cover)),
              child: const ExchangeCurrencies()));
    },
  ),
  // GoRoute(
  //     path: "/route1",
  //     builder: (BuildContext context, GoRouterState state) {
  //       return Scaffold(
  //         appBar: AppBar(title: const Text('Home Screen')),
  //         body: Center(
  //           child: ElevatedButton(
  //             onPressed: () => context.go('/details'),
  //             child: const Text('Go to the Details screen'),
  //           ),
  //         ),
  //       );
  //     })
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: "Exchange App",
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ));
  }
}
