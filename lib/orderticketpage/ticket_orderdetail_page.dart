import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';

class TicketOrderDetailPage extends StatefulWidget {
  final String title;
  final DateTime selectedDate;

  TicketOrderDetailPage({required this.title, required this.selectedDate});

  @override
  _TicketOrderDetailPageState createState() => _TicketOrderDetailPageState();
}

class _TicketOrderDetailPageState extends State<TicketOrderDetailPage> {
  int adultCount = 0;
  int kidsCount = 0;
  int under3Count = 0;

  static const int adultPrice = 300000;
  static const int kidsPrice = 200000;
  static const int under3Price = 100000;

  int get totalPrice =>
      (adultCount * adultPrice) +
      (kidsCount * kidsPrice) +
      (under3Count * under3Price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Ticket Detail',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${adultCount + kidsCount + under3Count} Item of ${widget.title} on ${DateFormat.yMMMd().format(widget.selectedDate)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTicketDetail('Adults', adultCount, adultPrice, (newValue) {
              setState(() {
                adultCount = newValue;
              });
            }),
            const SizedBox(height: 10),
            _buildTicketDetail('Kids', kidsCount, kidsPrice, (newValue) {
              setState(() {
                kidsCount = newValue;
              });
            }),
            const SizedBox(height: 10),
            _buildTicketDetail('<3 Years', under3Count, under3Price,
                (newValue) {
              setState(() {
                under3Count = newValue;
              });
            }),
            const SizedBox(height: 20),
            Text(
              'Total Prices = Rp. ${NumberFormat('#,###').format(totalPrice)},00',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment logic here
                },
                child: const Text('Payment'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketDetail(
      String title, int count, int price, Function(int) onChanged) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              'https://via.placeholder.com/50', // Placeholder image URL
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp. ${NumberFormat('#,###').format(price)},00 /Pax',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (count > 0) {
                      onChanged(count - 1);
                    }
                  },
                ),
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    onChanged(count + 1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
