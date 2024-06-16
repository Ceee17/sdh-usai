import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/listdata/payment_list_data.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/paymentpage/success_page.dart';
import 'package:uas/widgets/button.dart';

class PaymentPage extends StatefulWidget {
  final String totalPrice;
  final List<CartFood>? cartItems;
  final List<Map<String, dynamic>>? zoneItems;
  final String sourcePage;

  const PaymentPage({
    super.key,
    required this.totalPrice,
    this.cartItems,
    this.zoneItems,
    required this.sourcePage,
  }) : assert(
            (sourcePage == 'ticket' &&
                    zoneItems != null &&
                    cartItems == null) ||
                (sourcePage != 'ticket' &&
                    cartItems != null &&
                    zoneItems == null),
            'For tickets, zoneItems must be provided and cartItems must be null. For non-tickets, cartItems must be provided and zoneItems must be null.');

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final double parsedTotalPrice = double.tryParse(
            widget.totalPrice.replaceAll(',', '').replaceAll('.', '')) ??
        0.0;
    final double tax = parsedTotalPrice * 0.1;
    final double finalPrice = parsedTotalPrice + tax;
    final numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              size: 50,
                            ),
                            w(16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Checkout Summary',
                                      style: headerText(16)),
                                  h(8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Subtotal'),
                                      Text(numberFormat
                                          .format(parsedTotalPrice)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tax 10%'),
                                      Text(numberFormat.format(tax)),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Price',
                                        style: customText(
                                            14, FontWeight.bold, primaryColor),
                                      ),
                                      Text(
                                        numberFormat.format(finalPrice),
                                        style: customText(
                                            14, FontWeight.bold, primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        h(16.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Order details',
                            style: linkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  h(16.0),
                  Text('Payment Method', style: headerText(16)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: paymentMethods.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod =
                                    paymentMethods[index]['value'] as int;
                              });
                            },
                            child: ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio(
                                    value:
                                        paymentMethods[index]['value'] as int,
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedPaymentMethod = value as int;
                                      });
                                    },
                                  ),
                                  Image.asset(
                                    paymentMethods[index]['image'] as String,
                                    width: 30,
                                  ),
                                ],
                              ),
                              title: Text(
                                  paymentMethods[index]['label'] as String),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  _handleProceedPayment(
                      context, numberFormat.format(finalPrice));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: PrimaryBtn('Proceed Payment'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleProceedPayment(BuildContext context, String finalPrice) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final paymentMethodLabel = _getPaymentMethodLabel(_selectedPaymentMethod);

      final historyData = {
        'userId': userId,
        'paymentMethod': paymentMethodLabel,
        'items': widget.sourcePage == 'ticket'
            ? widget.zoneItems!
                .map((item) => {
                      'title': item['title'],
                      'selectedDate': item['selectedDate'],
                      'adultCount': item['adultCount'],
                      'kidsCount': item['kidsCount'],
                      'adultPrice': item['adultPrice'],
                      'kidsPrice': item['kidsPrice'],
                      'totalPrice': item['totalPrice'],
                      'totalCount': item['totalCount'],
                      'category': item['category'],
                    })
                .toList()
            : widget.cartItems!
                .map((item) => {
                      'name': item.name,
                      'price': item.price,
                      'quantity': item.quantity,
                      'imageUrl': item.imageUrl,
                      'foodZone': item.foodZone,
                      'category': item.category,
                    })
                .toList(),
        'totalPrice': widget.totalPrice,
        'finalPrice': finalPrice,
        'date': Timestamp.now(),
      };

      await FirebaseFirestore.instance.collection('history').add(historyData);

      Fluttertoast.showToast(
        msg: "Payment Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: green,
        textColor: white,
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessPage(),
          ));
    }
  }

  String _getPaymentMethodLabel(int method) {
    switch (method) {
      case 1:
        return 'qris';
      case 2:
        return 'bca';
      case 3:
        return 'atm bersama';
      case 4:
        return 'gopay';
      case 5:
        return 'ovo';
      case 6:
        return 'dana';
      case 7:
        return 'linkaja';
      default:
        return 'unknown';
    }
  }
}
