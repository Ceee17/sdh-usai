import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/design/design.dart';
import 'package:uas/widgets/card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String selectedCategory = 'All';
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    User? user = _auth.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text("User not logged in"),
        ),
      );
    }

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
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('history')
                      .where('userId', isEqualTo: user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No history available"));
                    }

                    List<Map<String, dynamic>> historyItems =
                        snapshot.data!.docs
                            .map((doc) => {
                                  'imageUrl': doc['items'][0]['imageUrl'],
                                  'title': doc['items'][0]['name'],
                                  'date': (doc['date'] as Timestamp)
                                      .toDate()
                                      .toString(),
                                  'category': doc['items'][0]['category'],
                                })
                            .toList();

                    List<Map<String, dynamic>> filteredItems =
                        selectedCategory == 'All'
                            ? historyItems
                            : historyItems
                                .where((item) =>
                                    item['category'] == selectedCategory)
                                .toList();

                    return ListView(
                      children: filteredItems.map((item) {
                        return HistoryItem(
                          imageUrl: item['imageUrl']!,
                          title: item['title']!,
                          date: item['date']!,
                          category: item['category']!,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
