import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/combined_data.dart';
import 'package:uas/models/Searchable.dart';
import 'package:uas/widgets/grid.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Search',
          style: appBar,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: 420,
        height: 800,
        padding: EdgeInsets.all(16.0),
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
            h(20),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        "Well, there is no '$_currentQuery' result you are looking for :(",
                        style: customText(24, FontWeight.bold, black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : buildItemGrid(context, _filteredItems),
            ),
          ],
        ),
      ),
    );
  }
}
