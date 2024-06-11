import 'package:flutter/material.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';

class ForestZoneScreen extends StatefulWidget {
  const ForestZoneScreen({super.key});

  @override
  State<ForestZoneScreen> createState() => _ForestZoneScreenState();
}

class _ForestZoneScreenState extends State<ForestZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spooky Forest',
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
    title: "Witch's Brew Soup",
    price: 'Rp. 45,000,00',
    description:
        'A hearty pumpkin and butternut squash soup, served with a side of crusty bread.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Ghostly Shrimp',
    price: 'Rp. 60,000,00',
    description:
        'Sautéed shrimp in a garlic and butter sauce, served over a bed of wild rice.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Mystical Mushroom Risotto',
    price: 'Rp. 55,000,00',
    description: 'Creamy risotto with a mix of wild mushrooms and truffle oil.',
  ),
  Item(
    image: 'https://via.placeholder.com/150',
    title: 'Haunted House Brownies',
    price: 'Rp. 35,000,00',
    description:
        'Rich chocolate brownies with a spooky twist, topped with ghost-shaped marshmallows.',
  ),
  // Add more items here
];
