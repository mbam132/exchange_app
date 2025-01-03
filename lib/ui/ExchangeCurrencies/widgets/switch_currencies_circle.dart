import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

const SWITCH_CURRENCIES_CIRCLE_HEIGHT = 60.0;
const SWITCH_CURRENCIES_CIRCLE_WIDTH = 60.0;

class SwitchCurrenciesCircle extends StatelessWidget {
  final VoidCallback switchExchangeType;

  const SwitchCurrenciesCircle({super.key, required this.switchExchangeType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: switchExchangeType,
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
