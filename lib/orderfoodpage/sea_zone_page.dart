import 'package:flutter/material.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';

class SeaZoneScreen extends StatefulWidget {
  const SeaZoneScreen({super.key});

  @override
  State<SeaZoneScreen> createState() => _SeaZoneScreenState();
}

class _SeaZoneScreenState extends State<SeaZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Underwater Paradise',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChooseZonePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Placeholder(),
                ),
              );
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
                color: Colors.white,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Food List",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.5,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      items[index].image,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    items[index].title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    items[index].price,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    items[index].description ??
                                        'No description available',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${items[index].title} added to cart'),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(90),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add to cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: ItemCard(item: items[index]),
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

class Item {
  final String image;
  final String title;
  final String price;
  final String? description;

  Item({
    required this.image,
    required this.title,
    required this.price,
    this.description,
  });
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    item.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      item.price,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: const Icon(
            Icons.favorite_border,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

final List<Item> items = [
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Ocean Breeze Salad',
    price: 'Rp. 50,000,00',
    description:
        'Mixed greens topped with seared tuna, avocado, cucumber, and sesame dressing.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Seafood Paella',
    price: 'Rp. 72,000,00',
    description:
        'A traditional Spanish dish with saffron-infused rice, mussels, shrimp, calamari, and chorizo.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Salmon Sandwich',
    price: 'Rp. 85,000,00',
    description:
        'Grilled salmon filet with arugula, red onion, and a dill yogurt sauce on a toasted bun.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Tropical Fruit Bowl',
    price: 'Rp. 45,000,00',
    description:
        'A mix of fresh tropical fruits like pineapple, mango, and kiwi, served with a drizzle of honey.',
  ),
  // Add more items here
];
