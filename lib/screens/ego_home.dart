import 'package:flutter/material.dart';
import 'package:ego/widgets/top_bar.dart';
import 'package:ego/widgets/glass_card.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:ego/widgets/neu_summary_card.dart';
import 'package:ego/widgets/transactions_list.dart';
import 'package:ego/widgets/transaction_header.dart';

class EgoHome extends StatelessWidget {
  EgoHome({Key? key}) : super(key: key);

  final List<Transaction> transactions = [
    Transaction(
        id: 1,
        title: "Water",
        type: "expense",
        amount: 16,
        date: DateTime.now()),
    Transaction(
        id: 2, title: "Gift", type: "income", amount: 50, date: DateTime.now()),
    Transaction(
        id: 3, title: "Gift", type: "income", amount: 50, date: DateTime.now()),
    Transaction(
        id: 4,
        title: "Food",
        type: "expense",
        amount: 12,
        date: DateTime.now()),
    Transaction(
        id: 5,
        title: "Grapes",
        type: "expense",
        amount: 5,
        date: DateTime.now()),
    Transaction(
        id: 6,
        title: "Cloths",
        type: "income",
        amount: 500,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const TopBar(),
              kSpaceWidget,
              GlassCard(
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Analytics",
                      style: TextStyle(fontSize: 34, fontFamily: 'Poppins'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        NeuSummaryCard(
                          textType: "Income",
                          percentage: 100,
                          arrowDirection: 100,
                        ),
                        NeuSummaryCard(
                          textType: "Expenses",
                          percentage: 10,
                          arrowDirection: 100,
                          isPositive: false,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const TransactionHeader()
            ],
          ),
        ),
        TransactionsList(transactions: transactions)
      ],
    );
  }
}
