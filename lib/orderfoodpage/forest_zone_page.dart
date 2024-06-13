import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/card.dart';
import 'package:uas/widgets/grid.dart';

class ForestZonePage extends StatefulWidget {
  const ForestZonePage({super.key});

  @override
  State<ForestZonePage> createState() => _ForestZonePageState();
}

class _ForestZonePageState extends State<ForestZonePage> {
  @override
  Widget build(BuildContext context) {
    List<Food> filteredFood = filterFoodByZone('forest');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spooky Forest',
          style: appBar,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {
              navigateToForestCart(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PacketCard(),
              h(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Food List",
                    style: headerText(24),
                  ),
                ],
              ),
              h(10),
              buildFoodGrid(context, filteredFood),
            ],
          ),
        ),
      ),
    );
  }
}
