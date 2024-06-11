import 'package:flutter/material.dart';
import 'package:uas/design/design.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180,
        height: 42,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(fontSize: 18),
            )));
  }
}

class OrderButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const OrderButton({
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
      color: whiteAll,
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
