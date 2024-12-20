import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

String formatDouble(double numberIn) {
  final formatter = NumberFormat("#,##0.00");
  final formattedString = formatter.format(numberIn);

  return formattedString;
}

// For input widgets
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final int decimalDigits;

  ThousandsSeparatorInputFormatter({this.decimalDigits = 2});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    final newText = newValue.text.replaceAll(",", "");
    final double? newTextAsDouble = double.tryParse(newText);
    if (newTextAsDouble == null) return oldValue;

    final newCursorPosition = newValue.selection.extentOffset;

    return TextEditingValue(
        text: formatDouble(newTextAsDouble),
        selection: TextSelection.collapsed(offset: newCursorPosition));
  }
}

void waitToCall(int ms, void Function() callback) {
  Future.delayed(Duration(milliseconds: ms), callback);
}
