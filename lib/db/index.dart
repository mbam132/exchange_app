import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:src/db/types.dart';
import 'package:src/utils/constants.dart';

class SingletonDB {
  static final SingletonDB _instance = SingletonDB._internal();

  factory SingletonDB() {
    return _instance;
  }

  SingletonDB._internal();

  final DB_NAME = 'exchange.db';
  final EXCHANGE_HISTORY_TABLE_NAME = 'exchange_history';
  Database? db;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      if (Platform.isLinux || Platform.isWindows) {
        databaseFactory = databaseFactoryFfi;
        sqfliteFfiInit();
      }
    }

    db = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE $EXCHANGE_HISTORY_TABLE_NAME(id INTEGER PRIMARY KEY, inputted_amount REAL, fiat TEXT, crypto TEXT, exchange_type TEXT, exchange_rate REAL)");
      },
    );
  }

  Future<void> insertRow({tableName, tupleObject}) async {
    await db?.insert(tableName, tupleObject.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getAllRows({tableName}) async {
    final List<Map<String, Object?>>? rows = await db?.query(tableName);

    if (rows != null) {
      if (tableName == EXCHANGE_HISTORY_TABLE_NAME) {
        return [
          for (final {
                "inputted_amount": inputted_amount as double,
                'fiat': fiat as String,
                'crypto': crypto as String,
                "exchange_type": exchange_type as String,
                'exchange_rate': exchange_rate as double
              } in rows)
            ExchangeDbType(
                inputtedAmount: inputted_amount,
                fiatCurrencySymbol: fiat,
                cryptoCurrencySymbol: crypto,
                exchangeType: exchange_type == 'fiatToCrypto'
                    ? ExchangeTypeEnum.fiatCrypto
                    : ExchangeTypeEnum.cryptoFiat,
                exchangeRate: exchange_rate)
        ];
      }
    }

    return rows;
  }

  Future<int?> delete({tableName, columnId, value}) async {
    bool deleteAllData = columnId == null && value == null;
    int? rowsAffected;

    if (!deleteAllData) {
      rowsAffected = await db
          ?.delete(tableName, where: '$columnId = ?', whereArgs: [value]);
    } else {
      rowsAffected = await db?.delete(tableName);
    }

    return rowsAffected;
  }
}
