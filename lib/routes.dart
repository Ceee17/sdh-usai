import 'package:flutter/material.dart';
import 'package:uas/aboutus/about_us_page.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/auth/register_page.dart';
import 'package:uas/homepage/home_page.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/orderfoodpage/bird_zone_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';
import 'package:uas/orderfoodpage/fauna_zone_page.dart';
import 'package:uas/orderfoodpage/food_cart_page.dart';
import 'package:uas/orderfoodpage/forest_zone_page.dart';
import 'package:uas/orderfoodpage/sea_zone_page.dart';
import 'package:uas/orderticketpage/ticket_order_page.dart';
import 'package:uas/orderticketpage/ticket_orderdetail_page.dart';
import 'package:uas/paymentpage/payment_page.dart';

// LOGIN ROUTES
void navigateToSignup(BuildContext context) => Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: RegisterPage(), // Placeholder for SignupPage
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 850),
      ),
    );

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

// TICKET ROUTES
void navigateToTicketOrderDetailPage(
    BuildContext context, String title, DateTime date, String category) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TicketOrderDetailPage(
        title: title,
        selectedDate: date,
        category: category,
      ),
    ),
  );
}

// FOOD ZONE ROUTES
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

// PAYMENT ROUTES
void navigateToPaymentPage(BuildContext context, String totalPrice,
    List<Map<String, dynamic>> Items, String sourcePage) {
  List<CartFood> cartItems = Items.map((item) {
    String name = item['name'] ?? 'Unknown';
    int price = item['price'] ?? 0;
    int quantity = item['quantity'] ?? 0;
    String imageUrl = item['imageUrl'] ?? '';
    String foodZone = item['foodZone'] ?? '';
    String category = item['category'] ?? '';

    return CartFood(
      name: name,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
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
        sourcePage: '',
      ),
    ),
  );
}
