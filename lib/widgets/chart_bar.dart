import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 100,
          width: 45,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey, width: 1.0),
              //     color: Color.fromRGBO(220, 220, 220, 1),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,

                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
