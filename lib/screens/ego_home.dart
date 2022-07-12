import 'package:flutter/material.dart';
import 'package:ego/screens/about.dart';
import 'package:ego/widgets/top_bar.dart';
import 'package:ego/util/ui_helpers.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/models/transaction.dart';
import 'package:ego/services/date_service.dart';
import 'package:ego/widgets/analytics_card.dart';
import 'package:ego/screens/transaction_form.dart';
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

  List<Transaction> get _transactionsThisMonth {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateService.pastMonth);
    }).toList();
  }

  List<Transaction> get _recentTransactions {
    return _transactionsThisMonth.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _updateTransactionFn(Transaction transaction) {
    setState(() {
      var tx = _transactions.singleWhere((tx) => tx.id == transaction.id);
      tx.id = transaction.id;
      tx.title = transaction.title;
      tx.type = transaction.type;
      tx.amount = transaction.amount;
      tx.date = transaction.date;
    });

    widget.storage.writeToFile(_transactions);
  }

  bool _deleteTransactionFn(int transactionId) {
    bool isDeleted = false;

    setState(() {
      var count = _transactions.length;
      _transactions.removeWhere((tx) => tx.id == transactionId);
      isDeleted = count > _transactions.length;
    });
    widget.storage.writeToFile(_transactions);

    return isDeleted;
  }

  void _setFigures(transactions) {
    totalExpenses = Transaction.totalExpenses(transactions);
    totalIncome = Transaction.totalIncome(transactions);
    totalTx = totalIncome + totalExpenses;
  }

  void _addNewTransactionFn(Transaction transaction) {
    transaction.id = _transactions.length + 1;

    setState(() {
      _transactions.add(transaction);
    });

    widget.storage.writeToFile(_transactions);
  }

  void _showTransactionModal(BuildContext context,
      {transaction = '', String editType = ''}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => editType == Transaction.update
            ? TransactionForm(_updateTransactionFn,
                transaction: transaction, formType: Transaction.update)
            : TransactionForm(_addNewTransactionFn));
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
        child: SizedBox(
          height: screenHeightPercent(context, percentage: 0.07),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [About()]),
          ),
        ),
      ),
      body: Column(children: [
        Container(
          height: screenHeightPercent(context, percentage: 0.35),
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              TopBar(),
              AnalyticsCard(
                  totalIncome: totalIncome,
                  totalExpenses: totalExpenses,
                  total: totalIncome + totalExpenses,
                  recentTransactions: _recentTransactions),
            ],
          ),
        ),
        const TransactionHeader(),
        SizedBox(
          height: screenHeightPercent(context, percentage: 0.493),
          child: TransactionsList(
            transactions: (_transactionsThisMonth.reversed).toList(),
            updateAction: _showTransactionModal,
            deleteAction: _deleteTransactionFn,
          ),
        )
      ]),
    );
  }
}
