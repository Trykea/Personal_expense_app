import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import './models/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
    title: 'Personal Expenses',
    theme: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue, // Equivalent to primarySwatch
    barBackgroundColor: CupertinoColors.systemRed, // Equivalent to secondary color
    textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
    fontFamily: 'QuickSand',
    color: CupertinoColors.black, // Default text color
    )
    ,
    navTitleTextStyle: TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: CupertinoColors.white,
    ),
    actionTextStyle: TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: CupertinoColors.white,
    ),
    ),
    ),
    home: MyHomePage(),
    )
        : MaterialApp(
    title: 'Personal Expenses',
    // theme: ThemeData(
    //   primarySwatch: Colors.red,
    //   primaryColor: Colors.red,
    //   hintColor: Colors.blue,
    // ),
    theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    ).copyWith(
    secondary: Colors.red, // Replacement for accentColor
    ),
    fontFamily: 'QuickSand',
    textTheme: ThemeData.light().textTheme.copyWith(
    headlineSmall: TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),
    labelLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.bold, // Optional: Add weight if needed
    color: Colors.white, // Optional: Define a color for the text
    ),
    ),
    ),
    home: MyHomePage()
    ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: '1', title: 'Item1', amount: 9.99, date: DateTime.now()),
    Transaction(id: '2', title: 'Item2', amount: 19.99, date: DateTime.now()),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String addTitle, double addAmount,
      DateTime chosenDate) {
    final newTx = Transaction(
        title: addTitle,
        amount: addAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _openNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final AndroidAppBar = AppBar(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .primary,
      title: Text(
        'Personal Expenses',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () => _openNewTransactionModal(context),
          icon: Icon(Icons.add),
          color: Colors.white,
        )
      ],
    );
    final iosAppBar = CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
        style: TextStyle(color: Colors.white),
      ),
      trailing: CupertinoButton(
        padding: EdgeInsets.zero,
        // Removes default padding for a compact button
        onPressed: () => _openNewTransactionModal(context),
        child: Icon(
          CupertinoIcons.add, // Cupertino-style "add" icon
          color: CupertinoColors.white,
        ),
      ),
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
            AndroidAppBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final pagebody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch.adaptive(
                      value: _showChart,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                      AndroidAppBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                  height: (mediaQuery.size.height -
                      AndroidAppBar.preferredSize.height -
                      mediaQuery.padding.top) *
                      0.7,
                  child: Chart(_recentTransactions))
                  : txListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: pagebody,
      navigationBar: iosAppBar,
    )
        : Scaffold(
      appBar: AndroidAppBar,
      body: pagebody,
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        shape: RoundedRectangleBorder(
          // Example: Rounded edges
          borderRadius: BorderRadius.circular(40.0),
        ),
        onPressed: () => _openNewTransactionModal(context),
      ),
    );
  }
}
