import 'package:flutter/material.dart';
import 'package:uas/models/Searchable.dart';

typedef OnTap = Function(BuildContext context);

class Zone implements Searchable {
  final String image;
  final String title;
  final int? priceStart;
  final int? priceEnd;
  final void Function(BuildContext context)? onTap;
  final String category;
  final String description;
  final String zone;

  Zone({
    required this.image,
    required this.title,
    this.priceStart,
    this.priceEnd,
    this.onTap,
    required this.category,
    required this.description,
    required this.zone,
  });
}
