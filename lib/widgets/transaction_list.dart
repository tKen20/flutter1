import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionlist;

  final Function deleteTransaction;

  TransactionList(this.transactionlist, this.deleteTransaction);

// hien thi bang chi tieu
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactionlist.isEmpty
          ? Column(
              children: [
                Text('NO TRANSACTION LITS YET!'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png'),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('\$${transactionlist[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactionlist[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactionlist[index].date)),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTransaction(transactionlist[index].id)),
                  ),
                );
              },
              itemCount: transactionlist.length,
            ),
    );
  }
}
