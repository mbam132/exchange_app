import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import '../../../blocs/exchange_rate_bloc_event.dart';
import '../../../utils/constants.dart';
import '../../../utils/index.dart';
import '../../../blocs/exchange_rate_bloc.dart';

class ExchangeCurrenciesVm extends ChangeNotifier {
  final ExchangeRateBloc bloc;

  final Debouncer _debouncer = Debouncer();
  final REQUEST_DEBOUNCE_TIME = 750;

  ExchangeCurrenciesVm({required this.bloc});

  bool _showExchangeSpinner = false;
  bool get showExchangeSpinner => _showExchangeSpinner;

  void handleSetNewCurrency(
      String currencyType, String newCurrencySymbol) async {
    if (currencyType == 'fiat') {
      bloc.add(FiatCurrencyChangedEvent(fiatCurrencySymbol: newCurrencySymbol));
    } else {
      bloc.add(
          CryptoCurrencyChangedEvent(cryptoCurrencySymbol: newCurrencySymbol));
    }

    await handleFetchAndSetExchangeRate();
  }

  void handleSetInputAmount(double newInputValue) {
    bloc.add(InputtedAmountChangedEvent(newAmount: newInputValue));
    if (newInputValue != 0.0) {
      debouncedFetchAndSetExchangeRate(REQUEST_DEBOUNCE_TIME);
    }
  }

  void handleSwitchExchangeType() async {
    bloc.add(SwitchExchangeTypeEvent());

    await handleFetchAndSetExchangeRate();
  }

  Future<void> handleFetchAndSetExchangeRate() async {
    if (bloc.state.inputtedAmount == 0.0) {
      return;
    }

    await debouncedFetchAndSetExchangeRate(REQUEST_DEBOUNCE_TIME);
  }

  Future<void> debouncedFetchAndSetExchangeRate(int durationInMs) async {
    _debouncer.debounce(
        duration: Duration(milliseconds: durationInMs),
        onDebounce: () async {
          bloc.add(FetchAndSetExchangeRateEvent());
        });
  }

  void handleExchange() {
    _showExchangeSpinner = true;
    notifyListeners();

    int msToWait = 2500;
    waitToCall(msToWait, () {
      _showExchangeSpinner = false;
      notifyListeners();
    });
  }

  String get exchangeAndSymbol {
    String formattedExchangeRate = formatDouble(bloc.state.exchangeRate);
    String currencySymbol =
        bloc.state.exchangeType == ExchangeTypeEnum.fiatCrypto
            ? bloc.state.cryptoCurrency.symbol
            : bloc.state.fiatCurrency.symbol;

    return '= $formattedExchangeRate $currencySymbol';
  }

  String get receivedAmountAndSymbol {
    String formattedAmount =
        (bloc.state.inputtedAmount / bloc.state.exchangeRate).isNaN ||
                (bloc.state.inputtedAmount / bloc.state.exchangeRate).isInfinite
            ? '0'
            : (bloc.state.exchangeType == ExchangeTypeEnum.fiatCrypto
                ? (bloc.state.inputtedAmount / bloc.state.exchangeRate)
                    .toStringAsPrecision(3)
                : formatDouble(
                    bloc.state.inputtedAmount * bloc.state.exchangeRate));
    String currencySymbol =
        bloc.state.exchangeType == ExchangeTypeEnum.fiatCrypto
            ? bloc.state.cryptoCurrency.symbol
            : bloc.state.fiatCurrency.symbol;

    return '= $formattedAmount $currencySymbol';
  }

  String get estimatedTime {
    String amountOfTime = '10 min';

    return "= $amountOfTime";
  }
}
