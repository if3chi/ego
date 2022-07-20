import 'package:flutter/material.dart';
import 'package:ego/widgets/chart.dart';
import 'package:ego/widgets/glass_card.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/widgets/neu_summary_card.dart';

class AnalyticsCard extends StatelessWidget {
  final double total;
  final double totalIncome;
  final double totalExpenses;
  final List<Transaction> recentTransactions;

  const AnalyticsCard({
    Key? key,
    required this.total,
    required this.totalIncome,
    required this.totalExpenses,
    required this.recentTransactions,
  }) : super(key: key);

  double getPercentage(figure) => (figure / total) * 100;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      cardChild: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chart(recentTransactions: recentTransactions),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              NeuSummaryCard(
                textType: "Income",
                percentage: getPercentage(totalIncome),
                total: totalIncome,
              ),
              NeuSummaryCard(
                textType: "Expenses",
                percentage: getPercentage(totalExpenses),
                isPositive: false,
                total: totalExpenses,
              ),
            ])
          ]),
    );
  }
}
