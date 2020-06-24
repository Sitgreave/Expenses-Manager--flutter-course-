import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondTry/widgets/new_transaction.dart';
import 'package:secondTry/widgets/transaction_list.dart';

import './widgets/chart2.dart';
import './models/transaction.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses Manager',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch:  Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18 
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20  
            )),)
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  //String titleInput, amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions =[
  Transaction(
    id: 't1',
    title:' BLA',
    amount: 32.1,
    date: DateTime.now()
     )
  ];
  List<Transaction> get _recentTransaction{
    return _userTransactions.where((element) {
    return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount){
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString() 
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
   void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
      //NewTransaction(_addNewTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses Manager',
            //  style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
         // backgroundColor: Color.fromRGBO(133, 187, 101, 1),
          
          actions: <Widget>[
            IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)
            )
          ],
        ),
        
        body:SingleChildScrollView(child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
        
          children: <Widget>[
            Chart2(_recentTransaction),
          TransactionList(_userTransactions), 
        ])),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),),
        );
  }
}
