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

  static bool isIncome(String type) => type == income;
}
