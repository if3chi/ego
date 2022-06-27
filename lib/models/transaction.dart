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

  static List<Transaction> get userTransactions => [
        Transaction(
            id: 1,
            title: "Water",
            type: "expense",
            amount: 16,
            date: DateTime.now()),
        Transaction(
            id: 2,
            title: "Gift",
            type: "income",
            amount: 50,
            date: DateTime.now()),
        Transaction(
            id: 3,
            title: "Gift",
            type: "income",
            amount: 50,
            date: DateTime.now()),
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
          date: DateTime.now(),
        ),
      ];

  static bool isIncome(String type) => type == income;
}
