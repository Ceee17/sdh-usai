import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  int _selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Payment',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
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
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Checkout Summary'),
                                SizedBox(height: 8.0),
                                Text('Subtotal'),
                                Text('Tax 10%'),
                                Text('Total Price'),
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 30.0), // Align text with icon
                                Text('600,000,00'),
                                Text('60,000,00'),
                                Text(
                                  '660,000,00',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            // Handle order details tap
                          },
                          child: Text(
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
                  SizedBox(height: 16.0),
                  Text(
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      separatorBuilder: (context, index) => Divider(),
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
                        ];

                        return ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: paymentMethods[index]['value'] as int,
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
                          title: Text(paymentMethods[index]['label'] as String),
                        );
                      },
                    ),
                  ))
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
                  // Handle proceed payment tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
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
}
