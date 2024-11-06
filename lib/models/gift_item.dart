class GiftItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String link;
  int totalQuantity;
  int selectedQuantity;

  GiftItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.totalQuantity,
    this.selectedQuantity = 0,
  });

  bool get isAvailable => selectedQuantity < totalQuantity;

  void select(int quantity) {
    selectedQuantity = (selectedQuantity + quantity).clamp(0, totalQuantity);
  }

  void deselect(int quantity) {
    selectedQuantity = (selectedQuantity - quantity).clamp(0, totalQuantity);
  }
}
