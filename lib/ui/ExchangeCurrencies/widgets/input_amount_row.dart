import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constants.dart';
import '../../../utils/index.dart';

class InputAmountRow extends StatelessWidget {
  final String currencySymbol;
  final double inputAmount;
  final void Function(double) handleSetInputAmount;

  const InputAmountRow(
      {super.key,
      required this.currencySymbol,
      required this.inputAmount,
      required this.handleSetInputAmount});

  Widget currencyIndicator(currencySymbol) {
    return Container(
        width: 60,
        alignment: Alignment.center,
        child: Text(
          currencySymbol,
          style: TextStyle(color: ELDORADO_YELLOW, fontWeight: FontWeight.bold),
        ));
  }

  Widget amountIndicator(handleSetInputAmount) {
    return Container(
      width: 241,
      height: 40.0,
      child: TextFormField(
          initialValue: "0.00",
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 3.5),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ThousandsSeparatorInputFormatter()
          ],
          onChanged: (value) {
            handleSetInputAmount(
                double.tryParse(value.replaceAll(",", "")) ?? 0.0);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ELDORADO_YELLOW, width: 2),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        currencyIndicator(currencySymbol),
        amountIndicator(handleSetInputAmount),
      ]),
    );
  }
}
