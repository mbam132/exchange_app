import '../types/index.dart';
import '../utils/constants.dart';

class ExchangeRateState {
  final double receivedAmount;
  final List<Currency> cryptoCurrenciesList;
  final List<Currency> fiatCurrenciesList;
  final Currency cryptoCurrency;
  final Currency fiatCurrency;
  final ExchangeTypeEnum exchangeType;
  final double exchangeRate;
  final double inputtedAmount;

  ExchangeRateState(
      {required this.receivedAmount,
      required this.cryptoCurrenciesList,
      required this.fiatCurrenciesList,
      required this.cryptoCurrency,
      required this.fiatCurrency,
      required this.exchangeType,
      required this.exchangeRate,
      required this.inputtedAmount});

  factory ExchangeRateState.initial() {
    // TODO: add the fetching of crypto and fiat currencies

    return ExchangeRateState(
        receivedAmount: 0.0,
        cryptoCurrenciesList: CRYPTO_CURRENCIES,
        fiatCurrenciesList: FIAT_CURRENCIES,
        cryptoCurrency: CRYPTO_CURRENCIES[0],
        fiatCurrency: FIAT_CURRENCIES[3],
        exchangeType: ExchangeTypeEnum.fiatCrypto,
        exchangeRate: 0.0,
        inputtedAmount: 0.0);
  }

  ExchangeRateState copyWith(
      {double? receivedAmount,
      List<Currency>? cryptoCurrenciesList,
      List<Currency>? fiatCurrenciesList,
      Currency? cryptoCurrency,
      Currency? fiatCurrency,
      ExchangeTypeEnum? exchangeType,
      double? exchangeRate,
      double? inputtedAmount}) {
    return ExchangeRateState(
        receivedAmount: receivedAmount ?? this.receivedAmount,
        cryptoCurrenciesList: cryptoCurrenciesList ?? this.cryptoCurrenciesList,
        fiatCurrenciesList: fiatCurrenciesList ?? this.fiatCurrenciesList,
        cryptoCurrency: cryptoCurrency ?? this.cryptoCurrency,
        fiatCurrency: fiatCurrency ?? this.fiatCurrency,
        exchangeType: exchangeType ?? this.exchangeType,
        exchangeRate: exchangeRate ?? this.exchangeRate,
        inputtedAmount: inputtedAmount ?? this.inputtedAmount);
  }
}
