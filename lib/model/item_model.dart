class Item {
  final int id;
  final String name;
  final double price;
  Item({required this.name, required this.id, required this.price});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price};
  }

  factory Item.formJson(dynamic data) {
    final id = data['id'];
    final name = data['name'];
    final price = data['price'];
    return Item(name: name, id: id, price: price);
  }
}
