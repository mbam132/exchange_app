import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:src/types/index.dart';
import 'package:src/ui/ExchangeCurrencies/widgets/currency_selector.dart';
import 'package:src/utils/constants.dart';

void main() {
  testWidgets(
      "CurrencySelector widget displays currency symbol and indication text",
      (tester) async {
    Currency selectedFiat = FIAT_CURRENCIES[3];
    String indicationText = 'Quiero';

    await tester.pumpWidget(MaterialApp(
        home: CurrencySelector(
            selectedCurrencySymbol: selectedFiat.symbol,
            indicationText: indicationText,
            handleSetNewCurrency: (string1, string2) {},
            typeOfCurrency: 'fiat')));

    final currencySymbolFinder = find.text(selectedFiat.symbol);
    final indicationTextFinder = find.text(indicationText.toUpperCase());

    expect(currencySymbolFinder, findsOneWidget);
    expect(indicationTextFinder, findsOneWidget);
  });

  testWidgets("Fiat currencies get displayed after tap", (tester) async {
    Currency selectedFiat = FIAT_CURRENCIES[3];
    String indicationText = 'Quiero';

    await tester.pumpWidget(MaterialApp(
        home: CurrencySelector(
            selectedCurrencySymbol: selectedFiat.symbol,
            indicationText: indicationText,
            handleSetNewCurrency: (string1, string2) {},
            typeOfCurrency: 'fiat')));

    int currenciesDisplayedBeforeTap = 0;
    FIAT_CURRENCIES.forEach((Currency currency) {
      final finder = find.text(currency.symbol);
      final elements = tester.elementList(finder);

      // don't count it because it already appears one time because it is already selected
      bool dountCountIt =
          elements.length == 1 && currency.symbol == selectedFiat.symbol;
      if (elements.isNotEmpty && !dountCountIt) {
        currenciesDisplayedBeforeTap += 1;
      }
    });

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    int currenciesDisplayedAfterTap = 0;
    FIAT_CURRENCIES.forEach((Currency currency) {
      final finder = find.text(currency.symbol);
      final elements = tester.elementList(finder);

      if (elements.isNotEmpty) {
        currenciesDisplayedAfterTap += 1;
      }
    });

    expect(currenciesDisplayedBeforeTap, equals(0));
    expect(currenciesDisplayedAfterTap, equals(FIAT_CURRENCIES.length));
  });

  testWidgets("Crypto currencies get displayed after tap", (tester) async {
    Currency selectedCrypto = CRYPTO_CURRENCIES[0];
    String indicationText = 'Tengo';

    await tester.pumpWidget(MaterialApp(
        home: CurrencySelector(
            selectedCurrencySymbol: selectedCrypto.symbol,
            indicationText: indicationText,
            handleSetNewCurrency: (string1, string2) {},
            typeOfCurrency: 'crypto')));

    int currenciesDisplayedBeforeTap = 0;
    CRYPTO_CURRENCIES.forEach((Currency currency) {
      final finder = find.text(currency.symbol);
      final elements = tester.elementList(finder);

      // don't count it because it already appears one time because it is already selected
      bool dountCountIt =
          elements.length == 1 && currency.symbol == selectedCrypto.symbol;
      if (elements.isNotEmpty && !dountCountIt) {
        currenciesDisplayedBeforeTap += 1;
      }
    });

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    int currenciesDisplayedAfterTap = 0;
    CRYPTO_CURRENCIES.forEach((Currency currency) {
      final finder = find.text(currency.symbol);
      final elements = tester.elementList(finder);

      if (elements.isNotEmpty) {
        currenciesDisplayedAfterTap += 1;
      }
    });

    expect(currenciesDisplayedBeforeTap, equals(0));
    expect(currenciesDisplayedAfterTap, equals(CRYPTO_CURRENCIES.length));
  });
}
