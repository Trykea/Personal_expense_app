import 'package:flutter/material.dart';

import './models/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
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
  void _addNewTransaction(String addTitle,double addAmount) {
    final newTx = Transaction(
        title: addTitle,
        amount: addAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });}
    void _openNewTransactionModal(BuildContext ctx) {
      showModalBottomSheet(context: ctx, builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      });
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Flutter App',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => _openNewTransactionModal(context), icon: Icon(Icons.add), color: Colors.white,)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text('Chart'),
                  elevation: 5,
                ),
              ),
              TransactionList(_userTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(child:
        Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder( // Example: Rounded edges
            borderRadius: BorderRadius.circular(40.0),
          ),
          onPressed: () => _openNewTransactionModal(context),

        )
        ,
      );
    }
  }

