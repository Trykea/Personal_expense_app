import 'dart:ffi';

import 'package:flutter/material.dart';

import '../widgets/transaction_list.dart';
import '../models/new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Item1', amount: 9.99, date: DateTime.now()),
    Transaction(id: '2', title: 'Item2', amount: 19.99, date: DateTime.now()),
  ];
  void _addNewTransaction(String addTitle,double addAmount){
    final newTx = Transaction( title: addTitle, amount: addAmount,date: DateTime.now(),id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
