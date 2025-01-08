import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:src/blocs/exchange_rate_bloc.dart';
import 'package:src/blocs/exchange_rate_bloc_event.dart';
import 'package:src/blocs/exchange_rate_bloc_state.dart';
import 'package:test/test.dart';
import 'package:src/types/index.dart';
import 'package:src/utils/constants.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'exchange_rate_bloc_test.mocks.dart' as mocks;
import '../mock_responses.dart';

@GenerateMocks([http.Client])
void main() {
  group("description", () {
    final client = mocks.MockClient();

    blocTest("The exchange rate is fetched and set in the state",
        build: () => ExchangeRateBloc(client),
        seed: () => ExchangeRateState.initial(),
        act: (bloc) {
          Currency fiatCurrency = FIAT_CURRENCIES[3];
          Currency cryptoCurrency = CRYPTO_CURRENCIES[0];
          double amount = 150.0;

          dynamic requestQueryParams = {
            'type': '0',
            'cryptoCurrencyId': cryptoCurrency.id,
            'fiatCurrencyId': fiatCurrency.id,
            'amount': amount.toString(),
            'amountCurrencyId': cryptoCurrency.id
          };

          when(client.get(Uri.https(
                  "74j6q7lg6a.execute-api.eu-west-1.amazonaws.com",
                  "/stage/orderbook/public/recommendations",
                  requestQueryParams)))
              .thenAnswer(
                  (_) async => http.Response(mockedRequestResponse, 200));

          return [
            bloc.add(InputtedAmountChangedEvent(newAmount: amount)),
            bloc.add(FiatCurrencyChangedEvent(
                fiatCurrencySymbol: fiatCurrency.symbol)),
            bloc.add(CryptoCurrencyChangedEvent(
                cryptoCurrencySymbol: cryptoCurrency.symbol)),
            bloc.add(SwitchExchangeTypeEvent()),
            bloc.add(FetchAndSetExchangeRateEvent()),
          ];
        },
        expect: () => [
              predicate((ExchangeRateState state) => true),
              predicate((ExchangeRateState state) => true),
              predicate((ExchangeRateState state) =>
                  state.exchangeRate == mockedExchangeRate)
            ]);
  });
}
