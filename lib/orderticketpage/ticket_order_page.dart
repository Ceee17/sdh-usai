import 'package:flutter/material.dart';

class OrderTicketPage extends StatefulWidget {
  const OrderTicketPage({super.key});

  @override
  State<OrderTicketPage> createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2 -
        20; // Calculate card width for 2 columns with padding

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Ticket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: featuredCardsData.map((data) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: cardWidth,
                        child: FeaturedCard(
                          imageUrl: data['imageUrl']!,
                          title: data['title']!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Most Picked',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: cardWidth /
                      250, // Adjust the aspect ratio to fit the content
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mostPickedCardsData.length,
                itemBuilder: (context, index) {
                  final data = mostPickedCardsData[index];
                  return MostPickedCard(
                    imageUrl: data['imageUrl']!,
                    title: data['title']!,
                    priceRange: data['priceRange']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FeaturedCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class MostPickedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String priceRange;

  const MostPickedCard({
    required this.imageUrl,
    required this.title,
    required this.priceRange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              priceRange,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

const List<Map<String, String>> featuredCardsData = [
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Land Explorer Bundle',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Sea Explorer Bundle',
  },
  // Add more featured cards here if needed
];

const List<Map<String, String>> mostPickedCardsData = [
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Jungle Expedition\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Underwater Paradise\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Sky Sanctuary\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Spooky Forest\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
  },
  // Add more most picked cards here if needed
];
