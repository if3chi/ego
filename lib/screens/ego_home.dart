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
  List<Transaction> _transactions = [];
  double totalTx = 0.0;
  double totalIncome = 0.0;
  double totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    widget.storage.loadTransactionsFromFile().then((value) {
      setState(() {
        _transactions = value;
      });
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _setFigures(transactions) {
    totalExpenses = Transaction.totalExpenses(transactions);
    totalIncome = Transaction.totalIncome(transactions);
    totalTx = totalIncome + totalExpenses;
  }

  Future<List<Transaction>> _addNewTransaction(
      String title, String type, double amount, DateTime date) {
    setState(() {
      _transactions.add(Transaction(
          id: _transactions.length + 1,
          title: title,
          type: type,
          amount: amount,
          date: date));
    });
    return widget.storage.writeToFile(_transactions);
  }

  void _showTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: NewTransaction(addTransaction: _addNewTransaction)));
  }

  @override
  Widget build(BuildContext context) {
    _setFigures(_transactions);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
          foregroundColor: kSwatch5,
          backgroundColor: kPrimaryColor,
          onPressed: () => _showTransactionModal(context),
          child: const Icon(Icons.add, size: 24, color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: kSwatch0,
          child: Container(height: MediaQuery.of(context).size.height * 0.07)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.425,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              children: [
                TopBar(),
                AnalyticsCard(
                    totalIncome: totalIncome,
                    totalExpenses: totalExpenses,
                    total: totalIncome + totalExpenses,
                    recentTransactions: _recentTransactions),
                const TransactionHeader()
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
              child: TransactionsList(
                  transactions: (_transactions.reversed).toList()))
        ],
      ),
    );
  }
}
