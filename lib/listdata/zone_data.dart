import 'package:flutter/material.dart';
import 'package:uas/routes.dart';

final List<Map<String, dynamic>> zoneData = [
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Jungle Expedition',
    'onTap': (BuildContext context) {
      navigateToFaunaZonePage(context);
    },
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Underwater Paradise',
    'onTap': (BuildContext context) {
      navigateToSeaZonePage(context);
    },
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Sky Sanctuary',
    'onTap': (BuildContext context) {
      navigateToBirdZonePage(context);
    },
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Spooky Forest',
    'onTap': (BuildContext context) {
      navigateToForestZonePage(context);
    },
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Coming Soon!',
    'onTap': (BuildContext context) {},
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Coming Soon!',
    'onTap': (BuildContext context) {},
  },
];
