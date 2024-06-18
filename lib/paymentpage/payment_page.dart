import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/listdata/payment_list_data.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/paymentpage/success_page.dart';
import 'package:uas/widgets/button.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:uas/services/token_service.dart';

class PaymentPage extends StatefulWidget {
  final String totalPrice;
  final List<CartFood> cartItems;
  final List<Map<String, dynamic>> zoneItems;
  final String sourcePage;

  PaymentPage({
    super.key,
    required this.totalPrice,
    required this.cartItems,
    required this.zoneItems,
    required this.sourcePage,
  });
  // : assert(
  //           (sourcePage == 'ticket' &&
  //                   zoneItems != null &&
  //                   cartItems == null) ||
  //               (sourcePage != 'ticket' &&
  //                   cartItems != null &&
  //                   zoneItems == null),
  //           'For tickets, zoneItems must be provided and cartItems must be null. For non-tickets, cartItems must be provided and zoneItems must be null.');

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MidtransSDK? _midtrans;
  late double parsedTotalPrice = double.tryParse(
          widget.totalPrice.replaceAll(',', '').replaceAll('.', '')) ??
      0.0;
  late double tax = parsedTotalPrice * 0.1;
  late double finalPrice = _calculatePrices();
  late int totalQuantity;
  late double totalZonePrice = 0.0;
  late int totalZoneQuantity = 0;

  @override
  void initState() {
    super.initState();
    _initSDK();
    _calculatePrices();
    _calculateTotalQuantity();
  }

  void _initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
        merchantBaseUrl: "",
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.blue,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      _showToast('Transaction Completed', false);
      _handleSuccessfulPayment();
    });
  }

  double _calculatePrices() {
    return parsedTotalPrice + tax;
  }

  void _calculateTotalQuantity() {
    totalQuantity =
        widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _showToast(String msg, bool isError) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleSuccessfulPayment() {
    User? user = _auth.currentUser;
    final numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    if (user != null) {
      final userId = user.uid;
      final paymentMethodLabel = _getPaymentMethodLabel(_selectedPaymentMethod);

      final historyData = {
        'userId': userId,
        'paymentMethod': paymentMethodLabel,
        'items': widget.sourcePage == 'ticket'
            ? widget.zoneItems
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
            : widget.cartItems
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
        'finalPrice': numberFormat.format(finalPrice),
        'date': Timestamp.now(),
      };

      FirebaseFirestore.instance.collection('history').add(historyData);

      setState(() {
        tempFoodCart.removeWhere(
            (item) => item.foodZone == widget.cartItems[0].foodZone);
        widget.cartItems.clear();
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
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
                            const Icon(
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
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  _handleProceedPayment(context);
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

  void _handleProceedPayment(BuildContext context) async {
    final numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    User? user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final paymentMethodLabel = _getPaymentMethodLabel(_selectedPaymentMethod);
      if (_selectedPaymentMethod == 8) {
        // Midtrans
        if (widget.sourcePage == 'ticket') {
          totalZonePrice = widget.zoneItems
              .fold(0.0, (sum, item) => sum + (item['totalPrice'] as num));
          totalZoneQuantity = widget.zoneItems
              .fold(0, (sum, item) => sum + (item['totalCount'] as int));

          double totalPrice = totalZonePrice + (totalZonePrice * 0.1);

          final result = await TokenService().getToken(
            widget.zoneItems.isNotEmpty
                ? widget.zoneItems[0]['title']
                : "Product",
            totalPrice,
            1,
          );

          if (result.isRight()) {
            String? token = result.fold((l) => null, (r) => r.token);
            if (token == null) {
              _showToast('Token cannot be null', true);
              return;
            }
            _midtrans?.startPaymentUiFlow(
              token: token,
            );
          } else {
            _showToast('Transaction Failed', true);
          }
        } else {
          totalZonePrice = 0.0;
          totalZoneQuantity = 0;

          final result = await TokenService().getToken(
            widget.cartItems.isNotEmpty ? widget.cartItems[0].name : "Product",
            this.finalPrice,
            totalQuantity,
          );

          if (result.isRight()) {
            String? token = result.fold((l) => null, (r) => r.token);
            if (token == null) {
              _showToast('Token cannot be null', true);
              return;
            }
            _midtrans?.startPaymentUiFlow(
              token: token,
            );
          } else {
            _showToast('Transaction Failed', true);
          }
        }
      } else {
        final historyData = {
          'userId': userId,
          'paymentMethod': paymentMethodLabel,
          'items': widget.sourcePage == 'ticket'
              ? widget.zoneItems
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
              : widget.cartItems
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
          'finalPrice': numberFormat.format(finalPrice),
          'date': Timestamp.now(),
        };

        await FirebaseFirestore.instance.collection('history').add(historyData);

        setState(() {
          tempFoodCart.removeWhere(
              (item) => item.foodZone == widget.cartItems[0].foodZone);
          widget.cartItems.clear();
        });

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
      case 8:
        return 'midtrans';
      default:
        return 'unknown';
    }
  }
}
