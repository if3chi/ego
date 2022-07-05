import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ego/services/notify.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:ego/widgets/transaction_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList(
      {Key? key,
      required this.transactions,
      required this.deleteAction,
      required this.updateAction})
      : super(key: key);

  final Function updateAction;
  final Function deleteAction;
  final List<Transaction> transactions;

  void cofirmDelete(BuildContext context, int index) {
    if (deleteAction(transactions[index].id)) {
      Notify.show(context: context, action: 'Deleted');
    }
  }

  void updateTx(BuildContext context, Transaction transaction) {
    updateAction(context,
        transaction: transaction, editType: Transaction.update);
  }

  @override
  Widget build(BuildContext context) {
    BuildContext parentContext = context;
    return Stack(children: [
      BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: kSwatch0.withOpacity(0.4),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      key: ValueKey(transactions[index].id),
                      endActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                            onPressed: (context) =>
                                updateTx(parentContext, transactions[index]),
                            backgroundColor: Colors.amber.shade500,
                            foregroundColor: Colors.white,
                            icon: Icons.edit),
                        SlidableAction(
                            onPressed: (context) => Notify.alert(
                                parentContext, cofirmDelete, index),
                            backgroundColor: kRed,
                            foregroundColor: Colors.white,
                            icon: Icons.delete),
                        SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colors.white,
                            foregroundColor: kRed,
                            icon: Icons.close)
                      ]),
                      child: TransactionCard(
                          txName: transactions[index].title,
                          txDate: transactions[index].date,
                          type: transactions[index].type,
                          amount: transactions[index].amount));
                })),
      )
    ]);
  }
}
