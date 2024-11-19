import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...transactions.map((tx) {
          return Card(
            child: Row(
              children: [
                Container(
                  child: Text(
                    '\$ ${tx.amount}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat.yMMMd().format(tx.date),
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey, width: 2)),
                )
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
