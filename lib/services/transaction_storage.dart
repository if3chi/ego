import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ego/models/transaction.dart';
import 'package:path_provider/path_provider.dart';

class TransactionStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/transaction.json');
  }

  Future<List<Transaction>> writeTransaction(
      List<Transaction> transactions) async {
    final file = await _localFile;

    var encodedTransactions =
        transactions.map((e) => jsonEncode(e.toJson())).toList().toString();

    file.writeAsString(encodedTransactions);
    return transactions;
  }

  Future<List<Transaction>> readTransaction() async {
    final file = await _localFile;

    if (await file.exists()) {
      try {
        var contents = jsonDecode(await file.readAsString());

        log("START CONTENT READING");
        log(contents.toString());
        List<Transaction> decodedContents = [];
        contents
            .map((data) => Transaction.fromJson(data))
            .forEach((transaction) => decodedContents.add(transaction));
        log("END CONTENT READING");

        return decodedContents;
      } catch (e) {
        log(e.toString());
      }
    }
    return [];
  }
}
