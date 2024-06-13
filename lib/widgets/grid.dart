import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas/design/design.dart';
import 'package:uas/listdata/food_data.dart';
import 'package:uas/models/CartItem.dart';
import 'package:uas/models/Item.dart';
import 'package:uas/widgets/button.dart';
import 'package:uas/widgets/card.dart';
import 'package:intl/intl.dart';

// FOODLIST GRID
Widget buildItemGrid(BuildContext context, List<Item> items) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: GridFixedCrossAxisCount(2, 3, 4, 10, 10),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () => showItemDetails(context, items[index]),
        child: ItemCard(item: items[index]),
      );
    },
  );
}

void showItemDetails(BuildContext context, Item item) {
  final formattedPrice = NumberFormat.decimalPattern('id').format(item.price);

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
                  item.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(item.title, style: clipText),
              SizedBox(height: 14),
              Text("Rp. $formattedPrice,00", style: priceText),
              SizedBox(height: 10),
              Text(item.description ?? 'No description available',
                  style: descText),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  bool itemFound = false;
                  for (var cartItem in tempFoodCart) {
                    if (cartItem.name == item.title &&
                        cartItem.foodZone == item.zone) {
                      cartItem.quantity++;
                      itemFound = true;
                      break;
                    }
                  }

                  if (!itemFound) {
                    tempFoodCart.add(CartItem(
                      name: item.title,
                      imageUrl: item.image,
                      price: item.price,
                      quantity: 1,
                      foodZone: item.zone,
                      category: item.category,
                    ));
                  }

                  Fluttertoast.showToast(
                    msg: "Item added to cart successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                },
                child: PrimaryButton(
                  label: 'Add To Cart',
                  onPressed: null,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
