import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'There\'s no item added yet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date)
                    ),
                    trailing: IconButton(onPressed:() => deleteTx(transactions[index].id), icon:Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary,)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
