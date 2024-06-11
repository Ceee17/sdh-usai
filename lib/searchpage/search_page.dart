import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _items = [
    {
      'title': 'Fauna Land',
      'price': 'Rp. 100,000,00 - Rp. 300,000,00',
      'image': 'assets/food1.png'
    },
    {
      'title': 'Sea World',
      'price': 'Rp. 100,000,00 - Rp. 300,000,00',
      'image': 'assets/food1.png'
    },
    {
      'title': 'Bird Land',
      'price': 'Rp. 100,000,00 - Rp. 300,000,00',
      'image': 'assets/food1.png'
    },
    {
      'title': 'Jungle Land',
      'price': 'Rp. 100,000,00 - Rp. 300,000,00',
      'image': 'assets/food1.png'
    },
    {
      'title': 'Easy homemade beef burger',
      'price': 'Rp. 85,000,00',
      'image': 'assets/food1.png'
    },
    {
      'title': 'Half boiled egg sandwich',
      'price': 'Rp. 45,000,00',
      'image': 'assets/food1.png'
    },
  ];

  List<Map<String, String>> _filteredItems = [];
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _currentQuery = query;
      _filteredItems = _items.where((item) {
        return item['title']?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Container(
        width: 420,
        height: 800,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ticket or food',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        "Well, there is no '$_currentQuery' result you are looking for :(",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: _filteredItems.map((item) {
                        return buildCard(
                          item['title'] ?? '',
                          item['price'] ?? '',
                          item['image'] ?? '',
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String price, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.0),
          Text(
            price,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
