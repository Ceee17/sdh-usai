import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/paymentpage/success_page.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:uas/services/token_service.dart';

class PaymentPage extends StatefulWidget {
  final String totalPrice;
  final List<CartFood> cartItems;

  const PaymentPage({
    super.key,
    required this.totalPrice,
    required this.cartItems,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MidtransSDK? _midtrans;
  late double parsedTotalPrice;
  late double tax;
  late double finalPrice;
  late int totalQuantity;

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

  void _calculatePrices() {
    parsedTotalPrice = double.tryParse(
            widget.totalPrice.replaceAll(',', '').replaceAll('.', '')) ??
        0.0;
    tax = parsedTotalPrice * 0.1;
    finalPrice = parsedTotalPrice + tax;
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
    if (user != null) {
      final userId = user.uid;
      final paymentMethodLabel = _getPaymentMethodLabel(_selectedPaymentMethod);

      final historyData = {
        'userId': userId,
        'paymentMethod': paymentMethodLabel,
        'items': widget.cartItems
            .map((item) => {
                  'name': item.name,
                  'quantity': item.quantity,
                  'price': item.price,
                  'imageUrl': item.imageUrl,
                  'foodZone': item.foodZone,
                  'category': item.category,
                })
            .toList(),
        'totalPrice': widget.totalPrice,
        'finalPrice': finalPrice,
        'date': Timestamp.now(),
      };

      FirebaseFirestore.instance.collection('history').add(historyData);

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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Checkout Summary',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Subtotal'),
                                      Text(numberFormat
                                          .format(parsedTotalPrice)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tax 10%'),
                                      Text(numberFormat.format(tax)),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Price',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        numberFormat.format(finalPrice),
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Order details',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 8, // Updated count to include Midtrans
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final paymentMethods = [
                            {
                              'label': 'QRIS',
                              'image': 'assets/payment/qris.png',
                              'value': 1
                            },
                            {
                              'label': 'BCA',
                              'image': 'assets/payment/bca.png',
                              'value': 2
                            },
                            {
                              'label': 'ATM Bersama',
                              'image': 'assets/payment/atm.png',
                              'value': 3
                            },
                            {
                              'label': 'Gopay',
                              'image': 'assets/payment/gopay.png',
                              'value': 4
                            },
                            {
                              'label': 'OVO',
                              'image': 'assets/payment/ovo.png',
                              'value': 5
                            },
                            {
                              'label': 'Dana',
                              'image': 'assets/payment/dana.png',
                              'value': 6
                            },
                            {
                              'label': 'LinkAja',
                              'image': 'assets/payment/linkaja.png',
                              'value': 7
                            },
                            {
                              'label': 'Midtrans', // Added Midtrans
                              'image': 'assets/payment/linkaja.png',
                              'value': 8
                            },
                          ];

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
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Proceed Payment',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleProceedPayment(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final paymentMethodLabel = _getPaymentMethodLabel(_selectedPaymentMethod);

      if (_selectedPaymentMethod == 8) {
        // Midtrans
        final result = await TokenService().getToken(
          widget.cartItems.isNotEmpty ? widget.cartItems[0].name : "Product",
          finalPrice,
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
      } else {
        final historyData = {
          'userId': userId,
          'paymentMethod': paymentMethodLabel,
          'items': widget.cartItems
              .map((item) => {
                    'name': item.name,
                    'quantity': item.quantity,
                    'price': item.price,
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
          backgroundColor: Colors.green,
          textColor: Colors.white,
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
