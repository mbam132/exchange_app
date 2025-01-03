import 'package:flutter_bloc/flutter_bloc.dart';
import './exchange_rate_bloc_event.dart';
import './exchange_rate_bloc_state.dart';
import '../utils/constants.dart';
import '../types/index.dart';
import '../repositories/exchange_repo.dart';

ExchangeRepository exchangeRepo = ExchangeRepository();

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super(ExchangeRateState.initial()) {
    on<InputtedAmountChangedEvent>((event, emit) {
      emit(state.copyWith(inputtedAmount: event.newAmount));
    });
    on<FiatCurrencyChangedEvent>((event, emit) {
      Currency newFiatCurrency = FIAT_CURRENCIES.firstWhere(
          (fiatCurrency) => fiatCurrency.symbol == event.fiatCurrencySymbol);

      emit(state.copyWith(fiatCurrency: newFiatCurrency));
    });
    on<CryptoCurrencyChangedEvent>((event, emit) {
      Currency newCryptoCurrency = FIAT_CURRENCIES.firstWhere(
          (cryptoCurrency) =>
              cryptoCurrency.symbol == event.cryptoCurrencySymbol);

      emit(state.copyWith(cryptoCurrency: newCryptoCurrency));
    });
    on<SwitchExchangeTypeEvent>((event, emit) {
      ExchangeTypeEnum newExchangeType;

      if (state.exchangeType == ExchangeTypeEnum.cryptoFiat) {
        newExchangeType = ExchangeTypeEnum.fiatCrypto;
      } else {
        newExchangeType = ExchangeTypeEnum.cryptoFiat;
      }

      emit(state.copyWith(exchangeType: newExchangeType));
    });
    on<ExchangeRateChangedEvent>((event, emit) {
      emit(state.copyWith(exchangeRate: event.newExchangeRate));
    });
    on<FetchAndSetExchangeRateEvent>((event, emit) async {
      dynamic queryParams = {
        'type': state.exchangeType == ExchangeTypeEnum.cryptoFiat ? '0' : '1',
        'cryptoCurrencyId': state.cryptoCurrency.id,
        'fiatCurrencyId': state.fiatCurrency.id,
        'amount': state.inputtedAmount.toString(),
        'amountCurrencyId': state.exchangeType == ExchangeTypeEnum.fiatCrypto
            ? state.fiatCurrency.id
            : state.cryptoCurrency.id
      };

      double? newExchangeRate =
          await exchangeRepo.fetchExchangeRate(queryParams);

      if (newExchangeRate != null) {
        emit(state.copyWith(exchangeRate: newExchangeRate));
      }
    });
  }
}
