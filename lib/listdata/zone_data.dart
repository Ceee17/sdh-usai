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
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel metus malesuada, hendrerit risus ac, tincidunt mauris. Phasellus rhoncus velit sit amet lectus viverra mollis.',
    zone: 'fauna',
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
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel metus malesuada, hendrerit risus ac, tincidunt mauris. Phasellus rhoncus velit sit amet lectus viverra mollis.',
    zone: 'sea',
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
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel metus malesuada, hendrerit risus ac, tincidunt mauris. Phasellus rhoncus velit sit amet lectus viverra mollis.',
    zone: 'bird',
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
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel metus malesuada, hendrerit risus ac, tincidunt mauris. Phasellus rhoncus velit sit amet lectus viverra mollis.',
    zone: 'forest',
  ),
];
