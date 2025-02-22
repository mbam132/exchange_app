import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:src/widgets/EDButton.dart';
import '../../../utils/constants.dart';
import '../view_model/exchange_currencies_vm.dart';
import '../../../blocs/exchange_rate_bloc.dart';
import '../../../blocs/exchange_rate_bloc_state.dart';
import 'input_amount_row.dart';
import 'currencies_row.dart';

class ExchangeCurrenciesScreen extends StatefulWidget {
  final ExchangeCurrenciesVm viewModel;

  const ExchangeCurrenciesScreen({super.key, required this.viewModel});

  @override
  State<ExchangeCurrenciesScreen> createState() => _ExchangeCurrencies();
}

class _ExchangeCurrencies extends State<ExchangeCurrenciesScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_refreshWidget);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_refreshWidget);
  }

  void _refreshWidget() {
    setState(() {});
  }

  Widget infoRow({description, value}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(22, 1, 22, 0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(description),
          Text(value),
        ]));
  }

  Widget exchangeButtonRow() {
    return Stack(alignment: Alignment.center, children: [
      EDButton(
        text: "Cambiar",
        pressHandle: widget.viewModel.handleExchange,
      ),
      if (widget.viewModel.showExchangeSpinner)
        Positioned(
          right: 110,
          top: 12,
          child: SpinKitRotatingCircle(color: ELDORADO_YELLOW, size: 20),
        )
    ]);
  }

  List<Widget> cardColumnItems({state}) {
    return [
      CurrenciesRow(
        typeOfExchange: state.exchangeType,
        switchExchangeType: widget.viewModel.handleSwitchExchangeType,
        handleSetNewCurrency: widget.viewModel.handleSetNewCurrency,
        fiatCurrency: state.fiatCurrency,
        cryptoCurrency: state.cryptoCurrency,
      ),
      InputAmountRow(
          currencySymbol: state.exchangeType == ExchangeTypeEnum.fiatCrypto
              ? state.fiatCurrency.symbol
              : state.cryptoCurrency.symbol,
          inputAmount: state.inputtedAmount,
          handleSetInputAmount: widget.viewModel.handleSetInputAmount),
      infoRow(
          description: "Tasa estimada",
          value: widget.viewModel.exchangeAndSymbol),
      infoRow(
          description: "Recibirás",
          value: widget.viewModel.receivedAmountAndSymbol),
      infoRow(
          description: "Tiempo estimado",
          value: widget.viewModel.estimatedTime),
      exchangeButtonRow()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
        builder: (context, state) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                width: EXCHANGE_CARD_WIDTH,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: cardColumnItems(state: state)))
          ],
        ),
      );
    }); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
