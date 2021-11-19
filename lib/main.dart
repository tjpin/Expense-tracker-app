// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/trans_card.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: HexColor("#22272C"),
      statusBarColor: HexColor("#22272C")));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        errorColor: Colors.red,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Theme.of(context).primaryColor,
            modalBackgroundColor: HexColor("#22272C")),
        colorScheme: ColorScheme.dark(),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: "Open_Sans",
                fontWeight: FontWeight.normal,
                fontSize: 25)),
        primaryColor: HexColor("#22272C"),
        splashColor: HexColor("#FFBF00"),
        fontFamily: "Open_Sans",
      ),
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage(this.transuctions);

  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void removeOne() {
    setState(() {
      _userTransactions.removeLast();
    });
  }

  void resetAll() {
    setState(() {
      _userTransactions.clear();
    });
  }

  void deleteSelected(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: "${DateTime.now()}",
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  Widget build(BuildContext ctx) {
    final appBar = AppBar(
      title: Text("Expense Tracker"),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
          onPressed: resetAll,
          icon: Icon(Icons.delete),
          splashRadius: 20.0,
        ),
        IconButton(
          onPressed: removeOne,
          icon: Icon(Icons.backspace),
          splashRadius: 20.0,
        ),
      ],
      leading: IconButton(
          onPressed: () {},
          splashRadius: 20.0,
          icon: const Icon(Icons.dark_mode)),
    );
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).primaryColor,
      body: _userTransactions.isEmpty
          ? Center(
              child: Text(
                "No Transactions!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: "Open_Sans",
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListView(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///////CHART /////////////////////
                    SizedBox(
                        height: ((MediaQuery.of(context).size.height * 0.25) -
                            appBar.preferredSize.height),
                        child: Chart(_recentTransactions)),
                    //////TEXT INPUT ///////////////////////
                    SizedBox(
                        height: ((MediaQuery.of(context).size.height * 0.75) -
                            appBar.preferredSize.height),
                        child:
                            TransactionList(_userTransactions, deleteSelected)),
                  ],
                ),
              ),
            ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBottomSheet(ctx),
        backgroundColor: Theme.of(context).splashColor,
        splashColor: Colors.black,
        elevation: 10.0,
        child: Icon(Icons.add),
        //   ),
      ),
    );
  }
}
