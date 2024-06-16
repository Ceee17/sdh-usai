import 'package:uas/models/Searchable.dart';

class Food implements Searchable {
  final String image;
  final String title;
  final int price;
  final String? description;
  final String zone;
  final String category;

  Food({
    required this.image,
    required this.title,
    required this.price,
    this.description,
    required this.zone,
    required this.category,
  });
}
