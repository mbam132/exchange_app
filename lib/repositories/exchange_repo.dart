import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/exchange_service.dart';

class ExchangeRepository {
  final ExchangeService _exchangeService = ExchangeService();

  Future<double?> fetchExchangeRate(dynamic queryParams) async {
    dynamic response = await _exchangeService.fetchExchangeRate(queryParams);

    bool responseIsSuccessful =
        response is http.Response && response.statusCode == 200;
    if (responseIsSuccessful) {
      double exchangeRate = double.parse(jsonDecode(response.body)['data']
          ['byPrice']['fiatToCryptoExchangeRate']);

      return exchangeRate;
    }
    return null;
  }
}
