import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uas/aboutus/about_us_page.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/models/CartItem.dart';
import 'package:uas/orderfoodpage/bird_zone_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';
import 'package:uas/orderfoodpage/fauna_zone_page.dart';
import 'package:uas/orderfoodpage/food_cart_page.dart';
import 'package:uas/orderfoodpage/forest_zone_page.dart';
import 'package:uas/orderfoodpage/sea_zone_page.dart';
import 'package:uas/orderticketpage/ticket_order_page.dart';
import 'package:uas/paymentpage/payment_page.dart';

// HOMEPAGE ROUTES
void navigateToHomePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}

void navigateToOrderTicketPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OrderTicketPage()),
  );
}

void navigateToOrderFoodPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChooseZonePage()),
  );
}

// PROFILE ROUTES
void navigateToLoginPage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false,
  );
}

void navigateToAboutUsPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutUsPage()),
  );
}

// ZONE ROUTES
void navigateToBirdZonePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const BirdZonePage(),
    ),
  );
}

void navigateToFaunaZonePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const FaunaZonePage(),
    ),
  );
}

void navigateToForestZonePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ForestZonePage(),
    ),
  );
}

void navigateToSeaZonePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SeaZonePage(),
    ),
  );
}

void navigateToFaunaCart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPage(foodZone: 'fauna'),
    ),
  );
}

void navigateToSeaCart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPage(foodZone: 'sea'),
    ),
  );
}

void navigateToBirdCart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPage(foodZone: 'bird'),
    ),
  );
}

void navigateToForestCart(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartPage(foodZone: 'forest'),
    ),
  );
}

void navigateToPaymentPage(BuildContext context, String totalPrice,
    List<Map<String, dynamic>> foodItems) {
  List<CartItem> cartItems = foodItems.map((item) {
    // Check for null values and provide defaults if necessary
    String name = item['name'] ?? 'Unknown';
    String imageUrl = item['imageUrl'] ?? '';
    int price = item['price'] ?? 0;
    int quantity = item['quantity'] ?? 0;
    String foodZone = item['foodZone'] ?? '';
    String category = item['category'] ?? '';

    return CartItem(
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity,
      foodZone: foodZone,
      category: category,
    );
  }).toList();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentPage(
        totalPrice: totalPrice,
        cartItems: cartItems,
      ),
    ),
  );
}
