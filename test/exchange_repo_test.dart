import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'exchange_repo_test.mocks.dart' as mocks;
import 'package:mockito/annotations.dart';
import 'package:src/repositories/exchange_repo.dart';
import './mock_responses.dart';

@GenerateMocks([http.Client])
void main() {
  test("The fetching of the exchange rate is done correctly", () async {
    final client = mocks.MockClient();
    ExchangeRepository exchangeRepo = ExchangeRepository(client);

    dynamic requestQueryParams = {
      'type': '0',
      'cryptoCurrencyId': 'TATUM-TRON-USDT',
      'fiatCurrencyId': 'VES',
      'amount': '150',
      'amountCurrencyId': 'TATUM-TRON-USDT'
    };

    when(client.get(Uri.https("74j6q7lg6a.execute-api.eu-west-1.amazonaws.com",
            "/stage/orderbook/public/recommendations", requestQueryParams)))
        .thenAnswer((_) async => http.Response(mockedRequestResponse, 200));

    double? fetchedExchangeRate =
        await exchangeRepo.fetchExchangeRate(requestQueryParams);

    expect(fetchedExchangeRate, mockedExchangeRate);
  });
}
