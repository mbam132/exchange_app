import 'package:flutter/material.dart';
import './CurrencySelector.dart';
import './utils/constants.dart';

const ROW_HEIGHT = 60.0;
const SWITCH_CURRENCIES_CIRCLE_HEIGHT = 60.0;
const SWITCH_CURRENCIES_CIRCLE_WIDTH = 60.0;

class CurrenciesRow extends StatelessWidget {
  final String firstCurrencyListType;
  final int firstListIndex;
  final int secondListIndex;

  final void Function(int, int) handleSetNewCurrency;
  final VoidCallback handleSwitchLists;

  const CurrenciesRow(
      {super.key,
      required this.firstCurrencyListType,
      required this.firstListIndex,
      required this.secondListIndex,
      required this.handleSwitchLists,
      required this.handleSetNewCurrency});

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
                  currenciesList: firstCurrencyListType == CURRENCY_TYPES[0]
                      ? FIAT_CURRENCIES
                      : CRYPTO_CURRENCIES,
                  selectedCurrencySymbol:
                      firstCurrencyListType == CURRENCY_TYPES[0]
                          ? FIAT_CURRENCIES[firstListIndex].symbol
                          : CRYPTO_CURRENCIES[firstListIndex].symbol,
                  indicationText: 'Tengo',
                  typeOfCurrency: firstCurrencyListType,
                  listNumber: 1),
              CurrencySelector(
                handleSetNewCurrency: handleSetNewCurrency,
                currenciesList: firstCurrencyListType == CURRENCY_TYPES[0]
                    ? CRYPTO_CURRENCIES
                    : FIAT_CURRENCIES,
                selectedCurrencySymbol:
                    firstCurrencyListType == CURRENCY_TYPES[1]
                        ? FIAT_CURRENCIES[secondListIndex].symbol
                        : CRYPTO_CURRENCIES[secondListIndex].symbol,
                indicationText: "Quiero",
                typeOfCurrency: firstCurrencyListType == CURRENCY_TYPES[1]
                    ? CURRENCY_TYPES[0]
                    : CURRENCY_TYPES[1],
                listNumber: 2,
              )
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            child: SwitchCurrenciesCircle(handleSwitchLists: handleSwitchLists))
      ]),
    );
  }
}

class SwitchCurrenciesCircle extends StatelessWidget {
  final VoidCallback handleSwitchLists;

  const SwitchCurrenciesCircle({super.key, required this.handleSwitchLists});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleSwitchLists,
        child: Container(
          width: SWITCH_CURRENCIES_CIRCLE_WIDTH,
          height: SWITCH_CURRENCIES_CIRCLE_HEIGHT,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ELDORADO_YELLOW,
          ),
          child: Icon(
            Icons.sync_alt,
            color: Colors.white,
            size: 32,
          ),
        ));
  }
}
