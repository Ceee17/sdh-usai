import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/widgets/button.dart';

// ITEM DETAILS MODAL
void showItemDetails(BuildContext context, Food food) {
  final formattedPrice = NumberFormat.decimalPattern('id').format(food.price);

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
