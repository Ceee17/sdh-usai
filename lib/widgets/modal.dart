import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/widgets/button.dart';

// FOOD DETAILS MODAL
void showFoodDetails(BuildContext context, Food food, String sourcePage) {
  final formattedPrice = NumberFormat.decimalPattern('id').format(food.price);

  void showConfirmationDialogSearchPage(Food item, String zone) {
    Zone? matchingZone;
    for (var zone in zoneData) {
      if (zone.zone == item.zone) {
        matchingZone = zone;
        break;
      }
    }

    String contentText;
    if (matchingZone != null) {
      contentText =
          "This will be added to your ${matchingZone.title} zone food cart. Are you sure? After added, it will bring you to ${matchingZone.title} zone page.";
    } else {
      contentText =
          "This will be added to your food cart. Are you sure? Access your food cart to see your order.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Text(contentText),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                bool foodFound = false;
                for (var cartItem in tempFoodCart) {
                  if (cartItem.name == food.title &&
                      cartItem.foodZone == food.zone) {
                    cartItem.quantity++;
                    foodFound = true;
                    break;
                  }
                  if (matchingZone != null) {
                    matchingZone.onTap(context);
                  }
                }

                if (!foodFound) {
                  tempFoodCart.add(CartFood(
                    name: food.title,
                    imageUrl: food.image,
                    price: food.price,
                    quantity: 1,
                    foodZone: food.zone,
                    category: food.category,
                  ));
                  if (matchingZone != null) {
                    matchingZone.onTap(context);
                  }
                }

                Fluttertoast.showToast(
                  msg: "${food.title} added to cart successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: black,
                  textColor: white,
                );
              },
            ),
          ],
        );
      },
    );
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  food.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              h(20),
              Text(food.title, style: clipText),
              h(14),
              Text("Rp. $formattedPrice,00", style: priceText),
              h(10),
              Text(food.description ?? 'No description available',
                  style: descText),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  if (sourcePage == 'searchPage') {
                    showConfirmationDialogSearchPage(food, food.zone);
                  } else {
                    bool foodFound = false;
                    for (var cartItem in tempFoodCart) {
                      if (cartItem.name == food.title &&
                          cartItem.foodZone == food.zone) {
                        cartItem.quantity++;
                        foodFound = true;
                        break;
                      }
                    }

                    if (!foodFound) {
                      tempFoodCart.add(CartFood(
                        name: food.title,
                        imageUrl: food.image,
                        price: food.price,
                        quantity: 1,
                        foodZone: food.zone,
                        category: food.category,
                      ));
                    }

                    Fluttertoast.showToast(
                      msg: "Item added to cart successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: black,
                      textColor: white,
                    );
                  }
                },
                child: PrimaryBtn('Add To Cart'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// ZONE DETAILS MODAL
void showZoneDetails(BuildContext context, Zone zone) {
  final formattedPrice = NumberFormat.decimalPattern('id');
  final formattedStartPrice = formattedPrice.format(priceStart);
  final formattedEndPrice = formattedPrice.format(priceEnd);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  zone.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              h(20),
              Text(
                zone.title,
                style: clipText,
              ),
              h(14),
              Text(
                "Rp. $formattedStartPrice,00 - Rp. $formattedEndPrice,00",
                style: priceText,
              ),
              h(10),
              Text(
                zone.description,
                style: descText,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: PrimaryBtn('Select Date'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
