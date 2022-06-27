import 'package:flutter/material.dart';
import 'package:ego/widgets/top_bar.dart';
import 'package:ego/widgets/glass_card.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:ego/widgets/new_transaction.dart';
import 'package:ego/widgets/neu_summary_card.dart';
import 'package:ego/widgets/transactions_list.dart';
import 'package:ego/widgets/transaction_header.dart';

class EgoHome extends StatefulWidget {
  const EgoHome({Key? key}) : super(key: key);

  @override
  State<EgoHome> createState() => _EgoHomeState();
}

class _EgoHomeState extends State<EgoHome> {
  final List<Transaction> transactions = Transaction.userTransactions;

  void _addNewTransaction(String title, String type, double amount) {
    setState(() {
      transactions.add(
        Transaction(
            id: transactions.length + 1,
            title: title,
            type: type,
            amount: amount,
            date: DateTime.now()),
      );
    });
  }

  void _showTransactionModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => NewTransaction(
        addTransaction: _addNewTransaction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        foregroundColor: kSwatch5,
        backgroundColor: kPrimaryColor,
        onPressed: () => _showTransactionModal(context),
        child: const Icon(
          Icons.add,
          size: 24,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: kSwatch0,
        child: Container(height: 60),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                const TopBar(),
                kSpaceWidget,
                const AnalysisCard(),
                const TransactionHeader()
              ],
            ),
          ),
          TransactionsList(transactions: (transactions.reversed).toList())
        ],
      ),
    );
  }
}

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
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
    );
  }
}
