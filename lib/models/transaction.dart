class Transaction {
  int id;
  String title;
  double amount;
  String type;
  DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.type,
      required this.amount,
      required this.date});
}
