import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/widgets/card.dart';

class ChooseZonePage extends StatefulWidget {
  const ChooseZonePage({super.key});

  @override
  State<ChooseZonePage> createState() => _ChooseZonePageState();
}

class _ChooseZonePageState extends State<ChooseZonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateToHomePage(context);
          },
        ),
        title: Text(
          "Choose Zone",
          style: appBar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: warningBox,
                child: Column(
                  children: [
                    Text("Warning!!!", style: warningText),
                    Text(
                      "Make sure you are in the right zone before ordering",
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
              h(20),
              Text(
                "Zone List",
                style: headerText(24),
              ),
              h(20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: zoneData.map((zone) {
                    return GestureDetector(
                      onTap: () => zone['onTap'](context),
                      child: ZoneCard(
                        imageUrl: zone['imageUrl'],
                        title: zone['title'],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToHomePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
}
