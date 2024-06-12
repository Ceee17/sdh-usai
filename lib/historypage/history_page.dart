import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';
import 'package:uas/widgets/card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String selectedCategory = 'All';

  final List<Map<String, String>> historyItems = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Noodle Ex',
      'date': '23 August 2021, 15:32',
      'category': 'Food',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Noodle Ex',
      'date': '23 August 2021, 15:32',
      'category': 'Food',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Fauna Land',
      'date': '23 August 2021, 15:32',
      'category': 'Ticket',
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'title': 'Sea World',
      'date': '23 August 2021, 15:32',
      'category': 'Ticket',
    },
  ];

  Widget buildChoiceChip(String label) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
      ),
      label: Text(label),
      selected: selectedCategory == label,
      onSelected: (bool selected) {
        setState(() {
          selectedCategory = label;
        });
      },
      selectedColor: Colors.orange,
      showCheckmark: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = selectedCategory == 'All'
        ? historyItems
        : historyItems
            .where((item) => item['category'] == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("History", style: appBar),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildChoiceChip('All'),
                  w(10),
                  buildChoiceChip('Ticket'),
                  w(10),
                  buildChoiceChip('Food'),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: filteredItems.map((item) {
                    return HistoryItem(
                      imageUrl: item['imageUrl']!,
                      title: item['title']!,
                      date: item['date']!,
                      category: item['category']!,
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
