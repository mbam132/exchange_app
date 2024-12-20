import 'dart:convert';
import 'package:flutter/material.dart';
import 'utils/index.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './CurrenciesRow.dart';
import './utils/constants.dart';
import './InputAmountRow.dart';
import './services/httpService.dart';

const REQUEST_DEBOUNCE_TIME = 750;
final Debouncer _debouncer = Debouncer();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exchange App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String firstCurrencyListType = CURRENCY_TYPES[0];
  int firstCurrencyListIndex = 3; //start with Venezuelan Bolívares
  int secondCurrencyListIndex = 0;

  double exchangeRate = 0.0;
  double inputAmount = 0.0;
  bool showExchangeSpinner = false;

  void handleSetNewCurrency(int listNumber, int newCurrencyIndex) async {
    if (listNumber == 1) {
      setState(() {
        firstCurrencyListIndex = newCurrencyIndex;
      });
    } else {
      // listNumber == 2
      setState(() {
        secondCurrencyListIndex = newCurrencyIndex;
      });
    }

    handleFetchAndSetExchangeRate();
  }

  void handleSetInputAmount(double newInputValue) {
    if (newInputValue != 0.0) {
      debouncedFetchAndSetExchangeRate(REQUEST_DEBOUNCE_TIME);
    }
    setState(() {
      inputAmount = newInputValue;
    });
  }

  void handleSwitchCurrencyLists() async {
    bool firsListIsFiat = firstCurrencyListType == CURRENCY_TYPES[0];
    String firstCurrencyTypeToSet;
    if (firsListIsFiat) {
      firstCurrencyTypeToSet = CURRENCY_TYPES[1];
    } else {
      firstCurrencyTypeToSet = CURRENCY_TYPES[0];
    }

    int newFirstIndex = secondCurrencyListIndex;
    int newSecondIndex = firstCurrencyListIndex;

    setState(() {
      firstCurrencyListType = firstCurrencyTypeToSet;
      firstCurrencyListIndex = newFirstIndex;
      secondCurrencyListIndex = newSecondIndex;
    });

    handleFetchAndSetExchangeRate();
  }

  String getCryptoIdSelected() {
    bool firstSelectorIsCrypto = firstCurrencyListType == CURRENCY_TYPES[1];
    if (firstSelectorIsCrypto) {
      return CRYPTO_CURRENCIES[firstCurrencyListIndex].id;
    } else {
      return CRYPTO_CURRENCIES[secondCurrencyListIndex].id;
    }
  }

  String getFiatIdSelected() {
    bool firstSelectorIsFiat = firstCurrencyListType == CURRENCY_TYPES[0];
    if (firstSelectorIsFiat) {
      return FIAT_CURRENCIES[firstCurrencyListIndex].id;
    } else {
      return FIAT_CURRENCIES[secondCurrencyListIndex].id;
    }
  }

  String getAmountCurrencyId() {
    bool amountIsCrypto = firstCurrencyListType == CURRENCY_TYPES[1];

    if (amountIsCrypto) {
      return CRYPTO_CURRENCIES[firstCurrencyListIndex].id;
    } else {
      return FIAT_CURRENCIES[firstCurrencyListIndex].id;
    }
  }

  void handleFetchAndSetExchangeRate() async {
    if (inputAmount == 0.0) {
      return;
    }

    await debouncedFetchAndSetExchangeRate(REQUEST_DEBOUNCE_TIME);
  }

  Future<void> debouncedFetchAndSetExchangeRate(int durationInMs) async {
    _debouncer.debounce(
        duration: Duration(milliseconds: durationInMs),
        onDebounce: () async {
          double? fetchedExchangeRate = await fetchExchangeRate() ?? 0;

          setState(() {
            exchangeRate = fetchedExchangeRate;
          });
        });
  }

  Future<double?> fetchExchangeRate() async {
    String endpoint = '/stage/orderbook/public/recommendations';
    dynamic requestQueryParams = {
      'type': firstCurrencyListType == CURRENCY_TYPES[1] ? '0' : '1',
      'cryptoCurrencyId': getCryptoIdSelected(),
      'fiatCurrencyId': getFiatIdSelected(),
      'amount': inputAmount.toString(),
      'amountCurrencyId': getAmountCurrencyId()
    };
    final response = await httpServiceGet(endpoint, requestQueryParams);

    bool responseWasSuccessful = response != null;
    if (responseWasSuccessful) {
      double exchangeRate = double.parse(jsonDecode(response.body)['data']
          ['byPrice']['fiatToCryptoExchangeRate']);
      return exchangeRate;
    } else {
      return 0;
    }
  }

  void handleExchange() {
    setState(() {
      showExchangeSpinner = true;
    });

    waitToCall(2500, () {
      setState(() {
        showExchangeSpinner = false;
      });
    });
  }

  String get exchangeAndSymbol {
    String formattedExchangeRate = formatDouble(exchangeRate);
    String currencySymbol = firstCurrencyListType == CURRENCY_TYPES[0]
        ? CRYPTO_CURRENCIES[secondCurrencyListIndex].symbol
        : FIAT_CURRENCIES[secondCurrencyListIndex].symbol;

    return '= $formattedExchangeRate $currencySymbol';
  }

  String get receivedAmountAndSymbol {
    String formattedAmount = (inputAmount / exchangeRate).isNaN ||
            (inputAmount / exchangeRate).isInfinite
        ? '0'
        : (firstCurrencyListType == CURRENCY_TYPES[0]
            ? (inputAmount / exchangeRate).toStringAsPrecision(3)
            : formatDouble(inputAmount * exchangeRate));
    String currencySymbol = firstCurrencyListType == CURRENCY_TYPES[0]
        ? CRYPTO_CURRENCIES[secondCurrencyListIndex].symbol
        : FIAT_CURRENCIES[secondCurrencyListIndex].symbol;

    return '= $formattedAmount $currencySymbol';
  }

  String get estimatedTime {
    String amountOfTime = '10 min';

    return "= $amountOfTime";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: null,
      body: Container(
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
                        firstCurrencyListType: firstCurrencyListType,
                        firstListIndex: firstCurrencyListIndex,
                        secondListIndex: secondCurrencyListIndex,
                        handleSwitchLists: handleSwitchCurrencyLists,
                        handleSetNewCurrency: handleSetNewCurrency,
                      ),
                      InputAmountRow(
                          currencySymbol: firstCurrencyListType ==
                                  CURRENCY_TYPES[0]
                              ? FIAT_CURRENCIES[firstCurrencyListIndex].symbol
                              : CRYPTO_CURRENCIES[firstCurrencyListIndex]
                                  .symbol,
                          inputAmount: inputAmount,
                          handleSetInputAmount: handleSetInputAmount),
                      Padding(
                          padding: EdgeInsets.fromLTRB(22, 6, 22, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tasa estimada"),
                                Text(exchangeAndSymbol),
                              ])),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Recibirás"),
                              Text(receivedAmountAndSymbol)
                            ]),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(22, 0, 22, 6),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tiempo estimado"),
                                Text(estimatedTime),
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
                                onPressed: handleExchange,
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
                        if (showExchangeSpinner)
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
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
