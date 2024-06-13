import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/combined_data.dart';
import 'package:uas/models/Searchable.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/models/Food.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Searchable> _filteredItems = [];
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(mixedList);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _currentQuery = query;
      _filteredItems = mixedList
          .where((item) {
            return item.title.toLowerCase().contains(query);
          })
          .cast<Searchable>()
          .toList();
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
        title: Text('Search', style: appBar),
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
                        if (item is Zone) {
                          return GestureDetector(
                            onTap: () => item.onTap(context),
                            child: buildCard(item.title, item.image, 'ticket'),
                          );
                        } else if (item is Food) {
                          return buildCard(item.title, item.image, 'food',
                              price: item.price);
                        }
                        return SizedBox.shrink();
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String imagePath, String category,
      {int? price}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          if (price != null)
            Text(
              'Rp. $price',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
