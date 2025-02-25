import 'package:flutter/material.dart';
import 'package:src/db/index.dart';
import 'package:src/db/types.dart';
import 'package:go_router/go_router.dart';
import 'package:src/utils/constants.dart';
import 'package:src/widgets/EDButton.dart';

class ExchangeHistoryScreen extends StatefulWidget {
  @override
  State<ExchangeHistoryScreen> createState() => _ExchangeHistory();
}

class _ExchangeHistory extends State<ExchangeHistoryScreen> {
  SingletonDB db = SingletonDB();

  List<ExchangeDbType> list = [];
  Future<void> fetchExchangeHistory() async {
    var fetchedList =
        await db.getAllRows(tableName: db.EXCHANGE_HISTORY_TABLE_NAME);

    setState(() {
      list = fetchedList;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchExchangeHistory();
  }

  Widget actionsRow({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 8),
        IntrinsicWidth(
            child: EDButton(
          text: "Ir atrás",
          pressHandle: () => {context.pop()},
        )),
        SizedBox(width: 10),
        IntrinsicWidth(
            child: EDButton(
          text: "Borrar la data",
          pressHandle: () => {
            db.delete(tableName: db.EXCHANGE_HISTORY_TABLE_NAME),
            setState(() {
              list = [];
            })
          },
        )),
      ],
    );
  }

  Widget listItem({index}) {
    return Container(
        height: 50,
        margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border(
              top: BorderSide(color: ELDORADO_YELLOW, width: 2.0),
              bottom: BorderSide(color: ELDORADO_YELLOW, width: 2.0),
              left: BorderSide(color: ELDORADO_YELLOW, width: 2.0),
              right: BorderSide(color: ELDORADO_YELLOW, width: 2.0),
            )),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Entrega"),
                Text(
                    list[index].exchangeType == ExchangeTypeEnum.fiatCrypto
                        ? list[index].fiatCurrencySymbol
                        : list[index].cryptoCurrencySymbol,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Recibe"),
                Text(
                    list[index].exchangeType == ExchangeTypeEnum.cryptoFiat
                        ? list[index].fiatCurrencySymbol
                        : list[index].cryptoCurrencySymbol,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Monto"),
                Text(list[index].inputtedAmount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tasa"),
                Text(
                  '${list[index].exchangeRate.toString()} ${list[index].fiatCurrencySymbol}/${list[index].cryptoCurrencySymbol}',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ]));
  }

  Widget exchangeList() {
    return Expanded(
        child: ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return listItem(index: index);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 350,
            width: CARD_WIDTH,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                actionsRow(context: context),
                if (list.isNotEmpty) exchangeList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
