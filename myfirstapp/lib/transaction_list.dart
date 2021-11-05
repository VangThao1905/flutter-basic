import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: (index - 1) % 2 == 0 ? Colors.pink : Colors.teal,
            elevation: 10,
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(transactions[index].content,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(
                        'Date: ${DateFormat("dd/MM/yyyy").format(transactions[index].createdDate)}',
                        style: TextStyle(color: Colors.white)),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${transactions[index].amount}\$',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: this._buildListView(),
    );
  }
}
