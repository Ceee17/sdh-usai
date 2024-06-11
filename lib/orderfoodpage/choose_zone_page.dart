import 'package:flutter/material.dart';
import 'package:uas/orderfoodpage/bird_zone_page.dart';
import 'package:uas/orderfoodpage/fauna_zone_page.dart';
import 'package:uas/orderfoodpage/forest_zone_page.dart';
import 'package:uas/orderfoodpage/sea_zone_page.dart';

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Choose Zone",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      "Warning!!!",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Make sure you are in the right zone before ordering",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Zone List",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaunaZoneScreen(),
                          ),
                        );
                      },
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Jungle Expedition',
                        description: 'Short Description',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeaZoneScreen(),
                          ),
                        );
                      },
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Underwater Paradise',
                        description: 'Short Description',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BirdZoneScreen(),
                          ),
                        );
                      },
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Sky Sanctuary',
                        description: 'Short Description',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForestZoneScreen(),
                          ),
                        );
                      },
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Spooky Forest',
                        description: 'Short Description',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Coming Soon!',
                        description: 'Short Description',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ZoneCard(
                        imageUrl: 'https://via.placeholder.com/150',
                        title: 'Coming Soon!',
                        description: 'Short Description',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoneCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  ZoneCard({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //   top: 8,
              //   right: 8,
              //   child: Icon(
              //     Icons.favorite,
              //     color: Colors.orange,
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
