class GiftItem {
  final int? id;
  final String name;
  final String? description;
  final double? price;
  final String? imagePath;

  GiftItem({this.id, required this.name, this.description, this.price, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory GiftItem.fromMap(Map<String, dynamic> map) {
    return GiftItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}
