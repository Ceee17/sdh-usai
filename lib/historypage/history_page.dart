import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
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
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    label: Text("All"),
                    selected: true,
                    onSelected: (bool selected) {},
                    selectedColor: Colors.orange,
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    label: Text("Ticket"),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90)),
                    label: Text("Food"),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    HistoryItem(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Noodle Ex',
                      date: '23 August 2021, 15:32',
                    ),
                    HistoryItem(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Noodle Ex',
                      date: '23 August 2021, 15:32',
                    ),
                    HistoryItem(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Fauna Land',
                      date: '23 August 2021, 15:32',
                    ),
                    HistoryItem(
                      imageUrl: 'https://via.placeholder.com/150',
                      title: 'Sea World',
                      date: '23 August 2021, 15:32',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;

  HistoryItem(
      {required this.imageUrl, required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
