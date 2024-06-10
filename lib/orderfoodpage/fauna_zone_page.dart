import 'package:flutter/material.dart';

class FaunaLandZoneScreen extends StatefulWidget {
  const FaunaLandZoneScreen({super.key});

  @override
  State<FaunaLandZoneScreen> createState() => _FaunaLandZoneScreenState();
}

class _FaunaLandZoneScreenState extends State<FaunaLandZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fauna Land Zone',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              // Shopping cart action
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
                color: Colors.grey[200],
                child: ListTile(
                  title: Text('Book Now !'),
                  subtitle: Text(
                    'Now You Can Buy Zoo Ticket and Some food cheaper...',
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Book Now action
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Picked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // See All action
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCard(item: items[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String image;
  final String title;
  final String price;

  Item({
    required this.image,
    required this.title,
    required this.price,
  });
}

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                item.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item.price,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}

final List<Item> items = [
  Item(
    image: 'https://example.com/image1.jpg',
    title: 'Sunny Egg & Toast Avocado',
    price: 'Rp. 50,000,00',
  ),
  Item(
    image: 'https://example.com/image2.jpg',
    title: 'Bowl of noodle with beef',
    price: 'Rp. 72,000,00',
  ),
  Item(
    image: 'https://example.com/image3.jpg',
    title: 'Easy homemade beef burger',
    price: 'Rp. 85,000,00',
  ),
  Item(
    image: 'https://example.com/image4.jpg',
    title: 'Half boiled egg sandwich',
    price: 'Rp. 45,000,00',
  ),
  // Add more items here
];
