import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:src/blocs/exchange_rate_bloc.dart';
import 'package:src/db/index.dart';
import 'package:src/utils/constants.dart';
import 'package:http/http.dart' as http;
import './ui/ExchangeCurrencies/index.dart';
import './ui/ExchangeHistory/index.dart';

void main() {
  final db = SingletonDB();
  db.initialize();

  runApp(MyApp());
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
  GoRoute(
    path: "/exchange-history",
    builder: (BuildContext context, GoRouterState state) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: null,
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: const AssetImage(BACKGROUND_IMAGE_PATH),
                      fit: BoxFit.cover)),
              child: const ExchangeHistory()));
    },
  )
]);

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final exchangeRateBloc = ExchangeRateBloc(http.Client());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        // in future all blocs will be added here
        create: (BuildContext context) => exchangeRateBloc,
        child: MaterialApp.router(
            title: "Exchange App",
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            )));
  }
}
