import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './view_model/exchange_currencies_vm.dart';
import '../../blocs/exchange_rate_bloc.dart';
import './widgets/exchange_currencies_screen.dart';

class ExchangeCurrencies extends StatelessWidget {
  const ExchangeCurrencies({super.key});

  @override
  Widget build(BuildContext context) {
    final exchangeRateBloc = ExchangeRateBloc();
    final viewModel = ExchangeCurrenciesVm(bloc: exchangeRateBloc);

    return BlocProvider(
      create: (BuildContext context) => exchangeRateBloc,
      child: ExchangeCurrenciesScreen(viewModel: viewModel),
    );
  }
}
