import 'package:flutter/material.dart';
import 'package:uas/accountpage/account_page.dart';
import 'package:uas/design/design.dart';
import 'package:uas/historypage/history_page.dart';
import 'package:uas/listdata/reviews_data.dart';
import 'package:uas/routes.dart';
import 'package:uas/searchpage/search_page.dart';
import 'package:uas/widgets/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    SearchPage(),
    HistoryPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ticket & Food',
              style: appBar,
            ),
            Text(
              'Ordering',
              style: appBar,
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order',
              style: headerText(18),
            ),
            h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OrderCard(
                  image: AssetImage('assets/ticket.png'),
                  label: 'Ticket',
                  onPressed: () {
                    navigateToOrderTicketPage(context);
                  },
                ),
                w(16),
                OrderCard(
                  icon: Icons.restaurant,
                  label: 'Food',
                  onPressed: () {
                    navigateToOrderFoodPage(context);
                  },
                ),
              ],
            ),
            h(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People’s Review',
                  style: headerText(18),
                ),
              ],
            ),
            h(10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: reviews
                      .map((review) => ReviewCard(review: review))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
