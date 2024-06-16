import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/button.dart';
import 'package:uas/widgets/card.dart';

class CartPage extends StatefulWidget {
  final String foodZone;

  CartPage({required this.foodZone});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _calculateTotal(int Function(CartFood) selector) {
    return tempFoodCart
        .where((item) => item.foodZone == widget.foodZone)
        .fold(0, (total, item) => total + selector(item));
  }

  void _updateQuantity(CartFood item, bool increment) {
    setState(() {
      if (increment) {
        item.quantity++;
      } else if (item.quantity > 0) {
        item.quantity--;
        if (item.quantity == 0) {
          _showConfirmationDialog(item);
        }
      }
    });
  }

  void _showConfirmationDialog(CartFood item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Item'),
          content:
              Text('Are you sure you want to remove this item from the cart?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                setState(() {
                  item.quantity++;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remove'),
              onPressed: () {
                setState(() {
                  tempFoodCart.remove(item);
                });
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "Item has been removed from cart",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CartFood> filteredCart =
        tempFoodCart.where((item) => item.foodZone == widget.foodZone).toList();
    final numberFormat = NumberFormat.decimalPattern('id');
    final totalPrice = numberFormat
        .format(_calculateTotal((item) => item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Cart',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: filteredCart.isEmpty
          ? Center(
              child: Text(
                "There is nothing here :(",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${_calculateTotal((item) => item.quantity)} Item',
                      style: customText(18, FontWeight.normal, grey),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCart.length,
                    itemBuilder: (context, index) =>
                        buildCartFoodCard(filteredCart[index], _updateQuantity),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Prices',
                          style: customText(18, FontWeight.w600, black)),
                      Text('Rp. $totalPrice,00',
                          style: customText(18, FontWeight.w600, black)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      navigateToPaymentPage(
                        context,
                        totalPrice,
                        filteredCart
                            .map((item) => {
                                  'name': item.name,
                                  'price': item.price,
                                  'quantity': item.quantity,
                                  'category': item.category,
                                  'imageUrl': item.imageUrl,
                                  'foodZone': item.foodZone,
                                })
                            .toList(),
                      );
                    },
                    child: PrimaryBtn('Payment'),
                  ),
                ),
              ],
            ),
    );
  }
}
