class Item {
  final String image;
  final String title;
  final int price;
  final String? description;
  final String zone;
  final String category;

  Item({
    required this.image,
    required this.title,
    required this.price,
    this.description,
    required this.zone,
    required this.category,
  });
}
