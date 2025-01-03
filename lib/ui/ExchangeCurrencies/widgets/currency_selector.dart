import 'package:flutter/material.dart';
import '../../../types/index.dart';
import '../../../utils/constants.dart';

const BOTTOM_MODAL_HEIGHT = 264.0;

class CurrencySelector extends StatelessWidget {
  final String selectedCurrencySymbol;
  final String indicationText;
  final String typeOfCurrency;

  final void Function(String, String) handleSetNewCurrency;

  const CurrencySelector(
      {super.key,
      required this.selectedCurrencySymbol,
      required this.indicationText,
      required this.handleSetNewCurrency,
      required this.typeOfCurrency});

  List<Currency> get currenciesList =>
      typeOfCurrency == 'fiat' ? FIAT_CURRENCIES : CRYPTO_CURRENCIES;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, side: BorderSide.none, elevation: 0),
      child: Container(
        margin: const EdgeInsets.all(0),
        height: 60,
        child: Stack(alignment: Alignment.center, children: [
          Container(
              margin: const EdgeInsets.all(0),
              height: 35,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border(
                      left: BorderSide(color: ELDORADO_YELLOW, width: 2.0),
                      right: BorderSide(color: ELDORADO_YELLOW, width: 2.0))),
              child: Text(
                selectedCurrencySymbol,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 3,
              child: Text(
                indicationText.toUpperCase(),
                style: TextStyle(fontSize: 8),
              ))
        ]),
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: BOTTOM_MODAL_HEIGHT,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          indicationText.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        child: CurrencyItemsSelect(
                            currenciesList: currenciesList,
                            selectedCurrencySymbol: selectedCurrencySymbol,
                            handleSetNewCurrency: handleSetNewCurrency,
                            bottomModalContext: context,
                            typeOfCurrency: typeOfCurrency))
                  ],
                ),
              );
            });
      },
    );
  }
}

class CurrencyItemsSelect extends StatelessWidget {
  final List<Currency> currenciesList;
  final String selectedCurrencySymbol;
  final BuildContext bottomModalContext;

  final String typeOfCurrency;

  final void Function(String, String) handleSetNewCurrency;

  const CurrencyItemsSelect(
      {super.key,
      required this.currenciesList,
      required this.selectedCurrencySymbol,
      required this.handleSetNewCurrency,
      required this.bottomModalContext,
      required this.typeOfCurrency});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: typeOfCurrency == 'fiat'
          ? FIAT_CURRENCIES.length
          : CRYPTO_CURRENCIES.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
            value: index ==
                currenciesList.indexWhere(
                    (currency) => currency.symbol == selectedCurrencySymbol),
            onChanged: (bool? newValue) {
              bool alreadySelectedCurrency =
                  currenciesList[index].symbol == selectedCurrencySymbol;

              if (alreadySelectedCurrency) {
                return;
              }

              String newCurrencySymbol = currenciesList[index].symbol;
              if (newValue != null) {
                // handleSetNewCurrency(type)

                handleSetNewCurrency(typeOfCurrency, newCurrencySymbol);
              }

              //close the modal
              Navigator.pop(bottomModalContext);
            },
            title: Row(children: [
              Image.asset(currenciesList[index].imagePath,
                  height: 25, width: 25),
              SizedBox(width: 8),
              Container(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currenciesList[index].symbol,
                        textAlign: TextAlign.start),
                    Text(
                      "${currenciesList[index].name} (${currenciesList[index].symbol2})",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ]));
      },
    );
  }
}
