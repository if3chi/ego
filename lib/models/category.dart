class Category {
  final int id;
  final String name;
  DateTime date;

  static List<Category> categories = [
    Category(id: 1, name: 'Bills', date: DateTime.now()),
    Category(id: 2, name: 'Business', date: DateTime.now()),
    Category(id: 3, name: 'Charity', date: DateTime.now()),
    Category(id: 4, name: 'Eating Out', date: DateTime.now()),
    Category(id: 5, name: 'Education', date: DateTime.now()),
    Category(id: 6, name: 'Family', date: DateTime.now()),
    Category(id: 7, name: 'General', date: DateTime.now()),
    Category(id: 8, name: 'Gift', date: DateTime.now()),
    Category(id: 9, name: 'Grocery', date: DateTime.now()),
    Category(id: 10, name: 'Holiday', date: DateTime.now()),
    Category(id: 11, name: 'Investment', date: DateTime.now()),
    Category(id: 12, name: 'Others', date: DateTime.now()),
    Category(id: 13, name: 'Personal Care', date: DateTime.now()),
    Category(id: 14, name: 'Shopping', date: DateTime.now()),
    Category(id: 15, name: 'Transport', date: DateTime.now()),
  ];

  Category({required this.id, required this.name, required this.date});

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date.toString(),
      };

  static getCategoryName(int id) =>
      categories.firstWhere((category) => category.id == id).name;
}
