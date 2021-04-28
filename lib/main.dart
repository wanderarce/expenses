
import 'dart:math';
import 'dart:ui';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transactions_component.dart';
import 'entities/transaction.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String title;

  String value;
  List<Transaction> transactions = [];
  bool _showChart = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
    print(appLifecycleState);
    PlatformDispatcher.instance.initialLifecycleState;
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    if (transactions == null || transactions.length == 0) {
      transactions = [];
      return transactions;
    } else {
      return transactions.where((tr) {
        return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
      title: Text("Home"),
      actions: [
        if (isLandscape)
          IconButton(
              icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              }),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context)),
      ],
    );
    var heightScreen = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Exibir gráfico"),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      }),
                ],
              ),
            if (_showChart || !isLandscape)
              Container(
                  height: heightScreen * (isLandscape ? .7 : .3),
                  child: Chart(_recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                padding: EdgeInsets.all(10),
                height: heightScreen * .7,
                child: TransactionsComponent(
                  transactions: transactions,
                  onRemove: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _addTransaction(String title, double value, DateTime date) {
    assert(title != null);
    final transaction =
        Transaction(Random().nextDouble().toString(), title, value, date);
    setState(() {
      transactions.add(transaction);
    });
    Navigator.of(context).pop();
  }
}
