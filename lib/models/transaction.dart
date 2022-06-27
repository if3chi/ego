class Transaction {
  int id;
  String title;
  double amount;
  String type;
  DateTime date;

  static String get income => "income";
  static String get expense => "expense";
  static String get debt =>
      // ignore: todo
      "debt"; // TODO: add reminder/push notification for debts.

  Transaction(
      {required this.id,
      required this.title,
      required this.type,
      required this.amount,
      required this.date});

  static List<Transaction> get userTransactions => [];

  static bool isIncome(String type) => type == income;

  static double totalIncome(List<Transaction> userTransactions) {
    double total = 0.0;
    for (var transaction in userTransactions) {
      if (transaction.type == Transaction.income) total += transaction.amount;
    }
    return total;
  }

  static double totalExpenses(List<Transaction> userTransactions) {
    double total = 0.0;
    for (var transaction in userTransactions) {
      if (transaction.type != Transaction.income) total += transaction.amount;
    }
    return total;
  }
}
