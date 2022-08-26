import 'package:flutter/material.dart';
import 'package:test3/models/transactions.dart';
import 'package:test3/widgets/charts.dart';
import 'package:test3/widgets/new_transactions.dart';
import 'package:test3/widgets/transactions_list.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({Key? key}) : super(key: key);

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: "Powerbank",
    //   amount: 8000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: "Notebook",
    //   amount: 250,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, int txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _showBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: const Icon(Icons.add)),
        ],
        title: const Text('My Expenses'),
      ),
      body: Container(
        alignment: Alignment.center,
        height: 300,
        child: _userTransactions.isEmpty
            ? Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'No transactions added yet',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ),
                  Image.asset(
                    'assets/images/waiting.png',
                    height: 200,
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Chart(recentTransactions: _recentTransactions),
                    TransactionList(_userTransactions, deleteTransaction),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
