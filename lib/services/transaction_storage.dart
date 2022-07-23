import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:path_provider/path_provider.dart';

import 'package:ego/models/transaction.dart';

class TransactionStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/transaction.json');
  }

  Future<List<Transaction>> writeToFile(List<Transaction> transactions) async {
    final file = await _localFile;

    file.writeAsString(
      transactions
          .map((transaction) => jsonEncode(transaction.toJson()))
          .toList()
          .toString(),
    );

    return transactions;
  }

  Future<List<Transaction>> loadTransactionsFromFile() async {
    final file = await _localFile;

    if (await file.exists()) {
      try {
        var contents = jsonDecode(await file.readAsString());

        List<Transaction> transactions = [];
        contents
            .map((data) => Transaction.fromJson(data))
            .forEach((transaction) => transactions.add(transaction));

        return transactions;
      } catch (e) {
        log(e.toString());
      }
    }
    return [];
  }
}
