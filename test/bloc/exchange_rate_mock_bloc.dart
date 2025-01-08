import 'package:bloc_test/bloc_test.dart';
import 'package:src/blocs/exchange_rate_bloc_event.dart';
import 'package:src/blocs/exchange_rate_bloc_state.dart';
import 'package:src/blocs/exchange_rate_bloc.dart';

class ExchangeRateMockBloc
    extends MockBloc<ExchangeRateEvent, ExchangeRateState>
    implements ExchangeRateBloc {}
