import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    // Generate the data for the past 7 days
    List<Map<String, Object>> values = List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1), // Abbreviation for the day
        'amount': totalSum,
        'weekday': weekday.weekday, // Add the weekday number for sorting
      };
    });

    // Sort the list based on the 'weekday' property
    values.sort((a, b) => (a['weekday'] as int).compareTo(b['weekday'] as int));

    // Remove 'weekday' key from the final result if not needed
    return values
        .map((data) => {
      'day': data['day'] as String,
      'amount': data['amount'] as double,
    })
        .toList();
  }



  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactionValues.map((data) {
                return Flexible(
                  fit:  FlexFit.tight,
                  child: ChartBar(
                      data['day'] as String,
                      (data['amount'] ?? 0.0) as double,
                      totalSpending== 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
                );
              }).toList(),
            ],
          ),
        ),
    );
  }
}
