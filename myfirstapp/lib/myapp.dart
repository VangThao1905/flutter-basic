import 'package:flutter/material.dart';
import 'package:myfirstapp/transaction_list.dart';

import 'transaction.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();

  Transaction _transaction =
      Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
  List<Transaction> _transactions = [];

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
  }

  void _insertTransaction() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN) return;
    _transaction.createdDate = DateTime.now();
    _transactions.add(_transaction);
    _transaction =
        Transaction(content: '', amount: 0.0, createdDate: DateTime.now());
    _contentController.text = '';
    _amountController.text = '';
  }

  void _onBottomShowModalSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Content'),
                controller: _contentController,
                onChanged: (text) {
                  setState(() {
                    _transaction.content = text;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount(money)'),
                controller: _amountController,
                onChanged: (text) {
                  setState(() {
                    _transaction.amount = double.tryParse(text)!;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                        child: SizedBox(
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text('Save',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          onPressed: () {
                            print('press save');
                            setState(() {
                              this._insertTransaction();
                            });
                          }),
                      height: 50,
                    )),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Expanded(
                        child: SizedBox(
                      child: RaisedButton(
                          color: Colors.pinkAccent,
                          child: Text('Cancel',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          onPressed: () {
                            print('press cancel');
                            Navigator.of(context).pop();
                          }),
                      height: 50,
                    ))
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction manager'),
        actions: [
          IconButton(
              onPressed: () {
                _onBottomShowModalSheet();
              },
              icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add transaction',
        child: const Icon(Icons.add),
        onPressed: () {
          _onBottomShowModalSheet();
        },
      ),
      key: _scaffoldKey,
      body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      child: const Text(
                        'Insert Transaction',
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Colors.pinkAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        this._onBottomShowModalSheet();
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content:
                              Text('transactions:' + _transactions.toString()),
                          duration: const Duration(seconds: 3),
                        ));
                      },
                    )),
                TransactionList(transactions: _transactions)
              ],
            ),
          )),
    );
  }
}
