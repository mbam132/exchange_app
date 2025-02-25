import 'package:src/utils/constants.dart';

class ExchangeDbType {
  final int? id;
  final double inputtedAmount;
  final String fiatCurrencySymbol;
  final String cryptoCurrencySymbol;
  final ExchangeTypeEnum exchangeType;
  final double exchangeRate;

  const ExchangeDbType(
      {this.id,
      required this.inputtedAmount,
      required this.fiatCurrencySymbol,
      required this.cryptoCurrencySymbol,
      required this.exchangeType,
      required this.exchangeRate});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "inputted_amount": inputtedAmount,
      'fiat': fiatCurrencySymbol,
      'crypto': cryptoCurrencySymbol,
      'exchange_type': exchangeType == ExchangeTypeEnum.cryptoFiat
          ? 'cryptoToFiat'
          : 'fiatToCrypto',
      'exchange_rate': exchangeRate
    };
  }
}
