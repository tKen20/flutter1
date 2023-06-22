import './widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';

import './widgets/chart.dart';

void main() {
  runApp(AppHome());
}

class AppHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP NGAY THANG',
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.blue,
          errorColor: Colors.green,
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(fontSize: 200),
                ),
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(id: '01', title: 'DAY 1', amont: 36, date: DateTime.now()),
    // Transaction(id: '02', title: 'DAY 2', amont: 63, date: DateTime.now()),
    // Transaction(id: '03', title: 'DAY 3', amont: 63, date: DateTime.now()),
  ];

  //them chi tieu 7 ngay gan nhat
  List<Transaction> get _recenTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  //them danh sach chi tieu
  void _addNewTransaction(String txTitle, double txMount, DateTime choseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txMount,
        date: choseDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  //hien thi button them danh sach chi tieu
  void _addStartNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  //chuc nang xoa

  void _deleTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APP CHI TIEU'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addStartNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Chart(_recenTransaction),
            TransactionList(_userTransaction, _deleTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addStartNewTransaction(context);
          }),
    );
  }
}
