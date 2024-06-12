import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/Item.dart';
import 'package:uas/models/Review.dart';

// HOMEPAGE CARD
class OrderCard extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const OrderCard({
    Key? key,
    this.icon,
    required this.label,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: white,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: FittedBox(
                        child: Image(
                          image: image!,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              if (icon != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  label,
                  style: labelText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              review.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(review.review),
        subtitle: Text(review.name),
      ),
    );
  }
}

// ZONE CARD
class ZoneCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  ZoneCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: cardText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FOOD CARD
class ItemCard extends StatefulWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    Fluttertoast.showToast(
      msg: isFavorite
          ? "Item has been saved to Favourites"
          : "Item has been removed from Favourites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        NumberFormat.decimalPattern('id').format(widget.item.price);
    return Stack(
      children: [
        Card(
          color: white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    widget.item.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 92,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item.title, style: cardText),
                    h(4),
                    Text("Rp. ${formattedPrice},00", style: priceText),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: primaryColor,
            ),
            onPressed: toggleFavorite,
          ),
        ),
      ],
    );
  }
}

// HISTORY CARD
class HistoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String category;

  HistoryItem({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          w(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: cardText),
              Text(date, style: priceText),
            ],
          ),
        ],
      ),
    );
  }
}
