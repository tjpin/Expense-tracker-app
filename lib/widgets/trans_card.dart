// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteOne;

  TransactionList(this.transactions, this.deleteOne);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            child: ListTile(
              trailing: IconButton(
                onPressed: () => deleteOne(transactions[index].id.toString()),
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                splashRadius: 25.0,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "${transactions[index].amount}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                radius: 30,
              ),
              title: Text(
                transactions[index].title,
                style: TextStyle(
                  color: Theme.of(context).splashColor,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  fontFamily: "Open_Sans",
                ),
              ),
              subtitle:
                  Text(DateFormat.yMMMd().format(transactions[index].date)),
            ),
          );
        },
      ),
    );
  }
}
