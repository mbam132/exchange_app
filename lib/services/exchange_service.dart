import 'package:http/http.dart' as http;

class ExchangeService {
  final String BASE_URL = '74j6q7lg6a.execute-api.eu-west-1.amazonaws.com';

  Future<http.Response?> fetchExchangeRate(dynamic queryParams) async {
    try {
      final String ENDPOINT = '/stage/orderbook/public/recommendations';
      final response =
          await http.get(Uri.https(BASE_URL, ENDPOINT, queryParams));

      return response;
    } on Exception catch (e) {
      print('An error occurred with the request');
      print(e.toString());
      return null;
    }
  }
}
