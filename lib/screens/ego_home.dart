import 'package:flutter/material.dart';
import 'package:ego/widgets/top_bar.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/utilities/constants.dart';
import 'package:ego/widgets/analytics_card.dart';
import 'package:ego/widgets/new_transaction.dart';
import 'package:ego/widgets/transactions_list.dart';
import 'package:ego/widgets/transaction_header.dart';
import 'package:ego/services/transaction_storage.dart';

class EgoHome extends StatefulWidget {
  EgoHome({Key? key}) : super(key: key);

  final TransactionStorage storage = TransactionStorage();

  @override
  State<EgoHome> createState() => _EgoHomeState();
}

class _EgoHomeState extends State<EgoHome> {
  List<Transaction> transactions = [];
  double totalTx = 0.0;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    widget.storage.loadTransactionsFromFile().then((value) {
      setState(() {
        transactions = value;
      });
    });
  }

  void _setFigures(transactions) {
    totalExpenses = Transaction.totalExpenses(transactions);
    totalIncome = Transaction.totalIncome(transactions);
    totalTx = totalIncome + totalExpenses;
  }

  Future<List<Transaction>> _addNewTransaction(
      String title, String type, double amount) {
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
    return widget.storage.writeToFile(transactions);
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
    _setFigures(transactions);

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
                TopBar(),
                kSpaceWidget,
                AnalyticsCard(
                  totalIncome: totalIncome,
                  totalExpenses: totalExpenses,
                  total: totalIncome + totalExpenses,
                ),
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
