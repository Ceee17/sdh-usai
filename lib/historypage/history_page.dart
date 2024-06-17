import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/History.dart';
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
      selectedColor: primaryColor,
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
        title: Text(
          "History",
          style: appBar,
        ),
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
              h(16),
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
                      String imageUrl;
                      if (items.isNotEmpty) {
                        if (items[0]['category'] == 'ticket') {
                          imageUrl = 'assets/ticketIcon.png';
                        } else if (items[0]['category'] == 'food') {
                          imageUrl = 'assets/foodIcon.png';
                        } else {
                          imageUrl = items[0]['imageUrl'] ?? '';
                        }
                      } else {
                        imageUrl = '';
                      }
                      return {
                        'imageUrl': imageUrl,
                        'title': items.isNotEmpty ? items[0]['name'] ?? '' : '',
                        'category':
                            items.isNotEmpty ? items[0]['category'] ?? '' : '',
                        'finalPrice': doc['finalPrice'] ?? '',
                        'paymentMethod': doc['paymentMethod'] ?? '',
                        'date': (doc['date'] as Timestamp).toDate().toString(),
                      };
                    }).toList();
                    if (selectedCategory != 'all') {
                      historyItems = historyItems.where((item) {
                        return item['category'].toString().toLowerCase() ==
                            selectedCategory;
                      }).toList();
                    }
                    return ListView(
                      children: historyItems.map((item) {
                        HistoryItem historyItem = HistoryItem(
                          imageUrl: item['imageUrl']!,
                          title: item['title']!,
                          category: item['category']!,
                          finalPrice: item['finalPrice']!,
                          paymentMethod: item['paymentMethod']!,
                          date: item['date']!,
                        );
                        return HistoryItemCard(historyItem: historyItem);
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
