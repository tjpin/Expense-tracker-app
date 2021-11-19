// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function updateTransuction;

  NewTransaction(this.updateTransuction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate;

  void submitTrans() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(priceController.text);

    if (enteredTitle.isEmpty || _selectedDate == null || enteredPrice <= 0) {
      return;
    }
    widget.updateTransuction(enteredTitle, enteredPrice, _selectedDate);

    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitTrans(),
            ),
            TextField(
              onSubmitted: (_) => submitTrans(),
              decoration: InputDecoration(labelText: "Amount"),
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? "No date selected"
                      : DateFormat.yMd().format(_selectedDate)),
                ),
                FlatButton(
                    splashColor: Colors.black,
                    onPressed: datePicker,
                    textColor: Theme.of(context).splashColor,
                    child: Text(
                      "Select Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            RaisedButton(
                onPressed: () {
                  submitTrans();
                },
                color: Theme.of(context).splashColor,
                elevation: 10,
                splashColor: Colors.white70,
                child: Text("Add Record",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                textColor: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}
