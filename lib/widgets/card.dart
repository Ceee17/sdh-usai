import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';

class ReviewCard extends StatelessWidget {
  final String review;
  final String name;
  final String image;

  const ReviewCard({
    Key? key,
    required this.review,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(review),
        subtitle: Text(name),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
