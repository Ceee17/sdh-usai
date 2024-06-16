import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/widgets/card.dart';
import 'package:uas/widgets/modal.dart';

// ZONELIST GRID
Widget buildZoneGrid(BuildContext context, List<Zone> zones) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
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
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: GridFixedCrossAxisCount(2, 0.8, 10, 10),
    itemCount: food.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => showItemDetails(context, food[index]),
        child: FoodCard(
          food: food[index],
        ),
      );
    },
  );
}
