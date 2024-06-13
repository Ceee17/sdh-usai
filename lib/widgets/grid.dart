import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/models/Searchable.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/widgets/card.dart';
import 'package:uas/widgets/modal.dart';

// ZONELIST GRID
Widget buildZoneGrid(BuildContext context, List<Zone> zones) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    gridDelegate: GridFixedCrossAxisCount(2, 1, 10, 10),
    itemCount: zones.length,
    itemBuilder: (context, int index) {
      return GestureDetector(
        onTap: () => zones[index].onTap(context),
        child: ZoneCard(
          zone: zones[index],
        ),
      );
    },
  );
}

// FOODLIST GRID
Widget buildFoodGrid(BuildContext context, List<Food> food) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    gridDelegate: GridFixedCrossAxisCount(2, 0.8, 10, 10),
    itemCount: food.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => showFoodDetails(context, food[index], ''),
        child: FoodCard(
          food: food[index],
        ),
      );
    },
  );
}

Widget buildSearchGrid(BuildContext context, List<Searchable> filteredItems) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    gridDelegate: GridFixedCrossAxisCount(2, 0.8, 10, 10),
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      final item = filteredItems[index];
      if (item is Zone) {
        return GestureDetector(
          onTap: () => showZoneDetails(context, item),
          child: SearchCard(
            item.title,
            item.image,
            'ticket',
            priceStart: item.priceStart,
            priceEnd: item.priceEnd,
          ),
        );
      } else if (item is Food) {
        return GestureDetector(
          onTap: () => showFoodDetails(context, item, 'searchPage'),
          child: SearchCard(
            item.title,
            item.image,
            'food',
            priceStart: item.price,
          ),
        );
      }
      return null;
    },
  );
}
