import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test3/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  late Function deleteTx;
  TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child:
                      FittedBox(child: Text('₦${transactions[index].amount}')),
                ),
              ),
              title: Text(
                transactions[index].title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat.yMMMMd().format(transactions[index].date),
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                onPressed: () {
                  deleteTx(transactions[index].id);
                },
                icon: Icon(Icons.delete),
                color: Colors.teal,
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
