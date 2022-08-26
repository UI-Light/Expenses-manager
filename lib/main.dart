import 'package:flutter/material.dart';
import 'package:test3/widgets/user_transactions.dart';

void main() {
  runApp(
    MaterialApp(
      home: const ExpensesView(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    ),
  );
}
