import 'package:flutter/material.dart';
import 'package:uas/aboutus/about_us_page.dart';
import 'package:uas/auth/login_page.dart';
import 'package:uas/orderfoodpage/bird_zone_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';
import 'package:uas/orderfoodpage/fauna_zone_page.dart';
import 'package:uas/orderfoodpage/food_cart_page.dart';
import 'package:uas/orderfoodpage/forest_zone_page.dart';
import 'package:uas/orderfoodpage/sea_zone_page.dart';

// HOMEPAGE ROUTES
void navigateToOrderTicketPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Placeholder()),
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
