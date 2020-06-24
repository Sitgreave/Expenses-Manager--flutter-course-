import 'package:flutter/material.dart';
import 'package:secondTry/models/transaction.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';
import 'package:intl/intl.dart';

class Chart2 extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart2(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'], 
              data['amount'],
              (data['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
