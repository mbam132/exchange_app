import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
          // buildWhen: (){
          // return true/false to determine whether or not
          // to rebuild the widget with state
          // },
          builder: (context, state) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage(BACKGROUND_IMAGE_PATH),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      width: EXCHANGE_CARD_WIDTH,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        CurrenciesRow(
                          typeOfExchange: state.exchangeType,
                          switchExchangeType:
                              widget.viewModel.handleSwitchExchangeType,
                          handleSetNewCurrency:
                              widget.viewModel.handleSetNewCurrency,
                          fiatCurrency: state.fiatCurrency,
                          cryptoCurrency: state.cryptoCurrency,
                        ),
                        InputAmountRow(
                            currencySymbol: state.exchangeType ==
                                    ExchangeTypeEnum.fiatCrypto
                                ? state.fiatCurrency.symbol
                                : state.cryptoCurrency.symbol,
                            inputAmount: state.inputtedAmount,
                            handleSetInputAmount:
                                widget.viewModel.handleSetInputAmount),
                        Padding(
                            padding: EdgeInsets.fromLTRB(22, 6, 22, 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tasa estimada"),
                                  Text(widget.viewModel.exchangeAndSymbol),
                                ])),
                        Padding(
                          padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Recibirás"),
                                Text(widget.viewModel.receivedAmountAndSymbol)
                              ]),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(22, 0, 22, 6),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tiempo estimado"),
                                  Text(widget.viewModel.estimatedTime),
                                ])),
                        Stack(alignment: Alignment.center, children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: widget.viewModel.handleExchange,
                                  style: TextButton.styleFrom(
                                      backgroundColor: ELDORADO_YELLOW,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the radius as needed
                                      )),
                                  child: const Text(
                                    "Cambiar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.viewModel.showExchangeSpinner)
                            Positioned(
                              right: 110,
                              top: 12,
                              child: SpinKitRotatingCircle(
                                  color: ELDORADO_YELLOW, size: 20),
                            )
                        ]),
                      ]))
                ],
              ),
            ));
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
