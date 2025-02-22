import 'package:flutter/material.dart';
import 'currency_selector.dart';
import '../../../utils/constants.dart';
import '../../../types/index.dart';
import './switch_currencies_circle.dart';

const ROW_HEIGHT = 60.0;

class CurrenciesRow extends StatelessWidget {
  final ExchangeTypeEnum typeOfExchange;
  final Currency fiatCurrency;
  final Currency cryptoCurrency;

  final void Function(String, String) handleSetNewCurrency;
  final VoidCallback switchExchangeType;

  const CurrenciesRow(
      {super.key,
      required this.switchExchangeType,
      required this.handleSetNewCurrency,
      required this.typeOfExchange,
      required this.fiatCurrency,
      required this.cryptoCurrency});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: ROW_HEIGHT,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CurrencySelector(
                handleSetNewCurrency: handleSetNewCurrency,
                selectedCurrencySymbol:
                    typeOfExchange == ExchangeTypeEnum.fiatCrypto
                        ? fiatCurrency.symbol
                        : cryptoCurrency.symbol,
                elevatedText: 'Tengo',
                typeOfCurrency: typeOfExchange == ExchangeTypeEnum.fiatCrypto
                    ? 'fiat'
                    : 'crypto',
              ),
              CurrencySelector(
                handleSetNewCurrency: handleSetNewCurrency,
                selectedCurrencySymbol:
                    typeOfExchange == ExchangeTypeEnum.cryptoFiat
                        ? fiatCurrency.symbol
                        : cryptoCurrency.symbol,
                elevatedText: "Quiero",
                typeOfCurrency: typeOfExchange == ExchangeTypeEnum.cryptoFiat
                    ? 'fiat'
                    : 'crypto',
              )
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            child:
                SwitchCurrenciesCircle(switchExchangeType: switchExchangeType))
      ]),
    );
  }
}
