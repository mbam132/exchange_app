import '../types/index.dart';
import 'package:flutter/material.dart';

const BACKGROUND_IMAGE_PATH = "assets/backgroundImage.jpeg";
const EXCHANGE_CARD_WIDTH = 350.0;

final List<Currency> FIAT_CURRENCIES = [
  Currency(
      symbol: 'BRL',
      symbol2: "BRL\$",
      name: "Real Brazileño",
      id: 'BRL',
      imagePath: 'fiat_currencies/BRL.png'),
  Currency(
      symbol: 'COP',
      symbol2: "COL\$",
      name: "Peso Colombiano",
      id: 'COP',
      imagePath: 'fiat_currencies/COP.png'),
  Currency(
      symbol: 'PEN',
      symbol2: "S/",
      name: "Sol Peruviano",
      id: "PEN",
      imagePath: 'fiat_currencies/PEN.png'),
  Currency(
      symbol: 'VES',
      symbol2: "Bs",
      name: "Bolívar Venezolano",
      id: 'VES',
      imagePath: 'fiat_currencies/VES.png')
];
final List<Currency> CRYPTO_CURRENCIES = [
  Currency(
      symbol: "USDT",
      symbol2: "USDT",
      name: "Tether",
      id: 'TATUM-TRON-USDT',
      imagePath: 'cripto_currencies/TATUM-TRON-USDT.png')
];

enum ExchangeTypeEnum { fiatCrypto, cryptoFiat }

const ELDORADO_YELLOW = Color(0xFFFFB200);

const BASE_URL = '74j6q7lg6a.execute-api.eu-west-1.amazonaws.com';
