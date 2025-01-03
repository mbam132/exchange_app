import '../types/index.dart';
import '../utils/constants.dart';

abstract class ExchangeRateEvent {}

class InputtedAmountChangedEvent extends ExchangeRateEvent {
  final double newAmount;
  InputtedAmountChangedEvent({required this.newAmount});
}

class FiatCurrencyChangedEvent extends ExchangeRateEvent {
  final String fiatCurrencySymbol;
  FiatCurrencyChangedEvent({required this.fiatCurrencySymbol});
}

class CryptoCurrencyChangedEvent extends ExchangeRateEvent {
  final String cryptoCurrencySymbol;

  CryptoCurrencyChangedEvent({required this.cryptoCurrencySymbol});
}

class SwitchExchangeTypeEvent extends ExchangeRateEvent {
  SwitchExchangeTypeEvent();
}

class ExchangeRateChangedEvent extends ExchangeRateEvent {
  final double newExchangeRate;
  ExchangeRateChangedEvent({required this.newExchangeRate});
}

class FetchAndSetExchangeRateEvent extends ExchangeRateEvent {
  FetchAndSetExchangeRateEvent();
}
