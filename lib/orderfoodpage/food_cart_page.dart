import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/CartItem.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/button.dart';

class CartPage extends StatefulWidget {
  final String foodZone;

  CartPage({required this.foodZone});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _calculateTotal(int Function(CartItem) selector) {
    return tempFoodCart
        .where((item) => item.foodZone == widget.foodZone)
        .fold(0, (total, item) => total + selector(item));
  }

  void _updateQuantity(CartItem item, bool increment) {
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

  void _showConfirmationDialog(CartItem item) {
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
    List<CartItem> filteredCart =
        tempFoodCart.where((item) => item.foodZone == widget.foodZone).toList();
    final numberFormat = NumberFormat.decimalPattern('id');
    final totalPrice = numberFormat
        .format(_calculateTotal((item) => item.price * item.quantity));

    Widget buildCartItemCard(CartItem item) {
      final itemPrice = numberFormat.format(item.price);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Rp. $itemPrice,00',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _updateQuantity(item, false),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _updateQuantity(item, true),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

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
                        buildCartItemCard(filteredCart[index]),
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
