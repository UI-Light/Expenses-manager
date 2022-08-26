import 'package:flutter/material.dart';
import 'package:test3/models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:test3/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, dynamic>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalTransactions = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalTransactions += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0, 1));
      print(totalTransactions);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalTransactions,
      };
    }).reversed.toList();
  }

  num get totalSpending {
    return groupTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(2),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionValues.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: e["day"],
                    amountSpent: e['amount'],
                    spendingPctOfTotal: e['amount'] / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
