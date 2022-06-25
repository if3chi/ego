import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:ego/widgets/transaction_card.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
        ),
        Container(
          height: 330,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: kSwatch0.withOpacity(0.4),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(
                  txName: transactions[index].title,
                  txDate: transactions[index].date,
                  type: transactions[index].type,
                  amount: transactions[index].amount,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
