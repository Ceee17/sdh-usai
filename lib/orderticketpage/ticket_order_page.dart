import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/orderticketpage/ticket_qty_page.dart';

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
    double cardHeight = 250; // Fixed height for cards

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
                        height: cardHeight,
                        child: GestureDetector(
                          onTap: () => _showDetailModal(context, data),
                          child: FeaturedCard(
                            imageUrl: data['imageUrl']!,
                            title: data['title']!,
                          ),
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
                  childAspectRatio:
                      cardWidth / cardHeight, // Ensure the aspect ratio matches
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mostPickedCardsData.length,
                itemBuilder: (context, index) {
                  final data = mostPickedCardsData[index];
                  return GestureDetector(
                    onTap: () => _showDetailModal(context, data),
                    child: MostPickedCard(
                      imageUrl: data['imageUrl']!,
                      title: data['title']!,
                      priceRange: data['priceRange']!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailModal(BuildContext context, Map<String, String> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          data['imageUrl']!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['description'] ?? 'No description available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () =>
                              _showCalendarModal(context, data['title']!),
                          child: const Text('Select Date'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCalendarModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateChanged: (date) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuantityPage(
                            title: title,
                            selectedDate: date,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
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
            ),
          ),
        ],
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
    'description':
        'Experience the thrill of land exploration with our exclusive bundle.',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Sea Explorer Bundle',
    'description':
        'Dive into the depths of the ocean with our sea explorer bundle.',
  },
  // Add more featured cards here if needed
];

const List<Map<String, String>> mostPickedCardsData = [
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Jungle Expedition\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
    'description':
        'Explore the jungle with a full day pass and discover exotic wildlife and plants.',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Underwater Paradise\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
    'description':
        'Dive into the underwater world with a full day pass and see amazing marine life.',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Sky Sanctuary\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
    'description':
        'Fly high in the sky sanctuary with a full day pass and enjoy breathtaking views.',
  },
  {
    'imageUrl': 'https://via.placeholder.com/150',
    'title': 'Spooky Forest\n(Full Day Pass)',
    'priceRange': 'Rp. 100,000,00 - Rp. 300,000,00',
    'description':
        'Enter the spooky forest with a full day pass and experience thrilling adventures.',
  },
  // Add more most picked cards here if needed
];
