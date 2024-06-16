import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/paymentpage/payment_page.dart';
import 'package:uas/widgets/button.dart';
import 'package:uas/widgets/card.dart';

class TicketOrderDetailPage extends StatefulWidget {
  final String title;
  final DateTime selectedDate;
  final String category;

  TicketOrderDetailPage(
      {required this.title,
      required this.selectedDate,
      required this.category});

  @override
  _TicketOrderDetailPageState createState() => _TicketOrderDetailPageState();
}

class _TicketOrderDetailPageState extends State<TicketOrderDetailPage> {
  int adultCount = 0;
  int kidsCount = 0;

  static const int adultPrice = 300000;
  static const int kidsPrice = 200000;

  int get totalPrice => (adultCount * adultPrice) + (kidsCount * kidsPrice);
  int get totalCount => (adultCount + kidsCount);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern('id');
    final itemPrice = numberFormat.format(totalPrice);
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
              '$totalCount Item of ${widget.title} on ${DateFormat.yMMMd().format(widget.selectedDate)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            h(10),
            TicketDetailCard('Adults', adultCount, adultPrice, (newValue) {
              setState(() {
                adultCount = newValue;
              });
            }),
            h(10),
            TicketDetailCard('Kids', kidsCount, kidsPrice, (newValue) {
              setState(() {
                kidsCount = newValue;
              });
            }),
            h(20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Prices',
                      style: customText(18, FontWeight.w600, black)),
                  Text('Rp. $itemPrice,00',
                      style: customText(18, FontWeight.w600, black)),
                ],
              ),
            ),
            h(20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: totalCount > 0
                    ? () {
                        navigateToPaymentPageFromTicket(
                          context,
                          totalPrice.toString(),
                          [
                            {
                              'title': widget.title,
                              'selectedDate': widget.selectedDate,
                              'adultCount': adultCount,
                              'kidsCount': kidsCount,
                              'adultPrice': adultPrice,
                              'kidsPrice': kidsPrice,
                              'totalPrice': totalPrice,
                              'totalCount': totalCount,
                              'category': widget.category,
                            }
                          ],
                          'ticket',
                        );
                      }
                    : null,
                child: totalCount > 0
                    ? PrimaryBtn('Payment')
                    : PrimaryBtnDisabled('Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToPaymentPageFromTicket(BuildContext context, String totalPrice,
    List<Map<String, dynamic>> items, String sourcePage) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentPage(
        totalPrice: totalPrice,
        zoneItems: items,
        sourcePage: sourcePage,
      ),
    ),
  );
}
