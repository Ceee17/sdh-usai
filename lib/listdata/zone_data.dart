import 'package:flutter/material.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/routes.dart';

final int priceStart = 100000;
final int priceEnd = 300000;
final int? priceStartCS = null;
final int? priceEndCS = null;

final List<Zone> zoneData = [
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Jungle Expedition',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToFaunaZonePage(context);
    },
    category: 'ticket',
  ),
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Underwater Paradise',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToSeaZonePage(context);
    },
    category: 'ticket',
  ),
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Sky Sanctuary',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToBirdZonePage(context);
    },
    category: 'ticket',
  ),
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Spooky Forest',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToForestZonePage(context);
    },
    category: 'ticket',
  ),
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Coming Soon!',
    priceStart: priceStartCS,
    priceEnd: priceEndCS,
    onTap: (BuildContext context) {},
    category: 'ticket',
  ),
  Zone(
    image: 'https://via.placeholder.com/150',
    title: 'Coming Soon!',
    priceStart: priceStartCS,
    priceEnd: priceEndCS,
    onTap: (BuildContext context) {},
    category: 'ticket',
  ),
];
