import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction({required this.addTx, Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool isSelected = false;

  void presentDatePicker() {
    print("this works");
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked != null) {
        setState(() {
          isSelected = true;
          selectedDate = picked;
          print(selectedDate);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      !isSelected
                          ? 'No Date Chosen'
                          : DateFormat.yMd().format(selectedDate),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      presentDatePicker();
                    },
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null)
                  widget.addTx(titleController.text,
                      int.parse(amountController.text), selectedDate);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal, onPrimary: Colors.white),
              child: const Text(
                'Add transaction',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
