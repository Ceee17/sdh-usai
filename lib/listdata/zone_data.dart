import 'package:flutter/material.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/routes.dart';

final int priceStart = 200000;
final int priceEnd = 300000;
final int? priceStartCS = null;
final int? priceEndCS = null;

final List<Zone> zoneData = [
  Zone(
    image: 'assets/zone/jungleexpedition.jpg',
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
    image: 'assets/zone/underwaterparadise.jpg',
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
    image: 'assets/zone/skysanctuary.jpg',
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
    image: 'assets/zone/spookyforest.jpg',
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
