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
  String selectedCategory = 'all';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget buildChoiceChip(String label) {
    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
      ),
      label: Text(label),
      selected: selectedCategory == label.toLowerCase(),
      onSelected: (bool selected) {
        setState(() {
          selectedCategory = label.toLowerCase();
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
      return const Scaffold(
        body: Center(
          child: Text("User not logged in"),
        ),
      );
    }

    Query query = FirebaseFirestore.instance
        .collection('history')
        .where('userId', isEqualTo: user.uid);

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
                  const SizedBox(width: 10),
                  buildChoiceChip('Ticket'),
                  const SizedBox(width: 10),
                  buildChoiceChip('Food'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: query.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No history available"));
                    }

                    List<Map<String, dynamic>> historyItems =
                        snapshot.data!.docs.map((doc) {
                      var items = List<Map<String, dynamic>>.from(doc['items']);
                      return {
                        'imageUrl': items[0]['imageUrl'],
                        'title': items[0]['name'],
                        'category': items[0]['category'],
                        'finalPrice': doc['finalPrice'],
                        'paymentMethod': doc['paymentMethod'],
                        'date': (doc['date'] as Timestamp).toDate().toString(),
                      };
                    }).toList();

                    // Filter items based on selectedCategory
                    if (selectedCategory != 'all') {
                      historyItems = historyItems.where((item) {
                        return item['category'].toString().toLowerCase() ==
                            selectedCategory;
                      }).toList();
                    }

                    return ListView(
                      children: historyItems.map((item) {
                        return HistoryItem(
                          imageUrl: item['imageUrl']!,
                          title: item['title']!,
                          category: item['category']!,
                          finalPrice: item['finalPrice']!,
                          paymentMethod: item['paymentMethod']!,
                          date: item['date']!,
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
