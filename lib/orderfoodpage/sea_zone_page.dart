import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/card.dart';
import 'package:uas/widgets/grid.dart';

class SeaZonePage extends StatefulWidget {
  const SeaZonePage({super.key});

  @override
  State<SeaZonePage> createState() => _SeaZonePageState();
}

class _SeaZonePageState extends State<SeaZonePage> {
  @override
  Widget build(BuildContext context) {
    List<Food> filteredFood = filterFoodByZone('sea');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Underwater Paradise',
          style: appBar,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {
              navigateToSeaCart(context);
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
