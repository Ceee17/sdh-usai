import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/grid.dart';

class ForestZonePage extends StatefulWidget {
  const ForestZonePage({super.key});

  @override
  State<ForestZonePage> createState() => _ForestZonePageState();
}

class _ForestZonePageState extends State<ForestZonePage> {
  @override
  Widget build(BuildContext context) {
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
              Card(
                color: white,
                elevation: 4,
                child: ListTile(
                  title: const Text('Book Now !'),
                  subtitle: const Text(
                    'Now You Can Buy Zoo Ticket and Some food cheaper...',
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                ),
              ),
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
              buildItemGrid(context, forestItems),
            ],
          ),
        ),
      ),
    );
  }
}
