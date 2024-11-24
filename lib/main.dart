import 'package:flutter/material.dart';

import './models/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      //   primaryColor: Colors.red,
      //   hintColor: Colors.blue,
      // ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.red, // Replacement for accentColor
        ),
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headlineSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              labelLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold, // Optional: Add weight if needed
            color: Colors.white, // Optional: Define a color for the text
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Item1', amount: 9.99, date: DateTime.now()),
    Transaction(id: '2', title: 'Item2', amount: 19.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String addTitle, double addAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: addTitle,
        amount: addAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _openNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        'Personal Expenses',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () => _openNewTransactionModal(context),
          icon: Icon(Icons.add),
          color: Colors.white,
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.4,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.6,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          // Example: Rounded edges
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () => _openNewTransactionModal(context),
      ),
    );
  }
}
