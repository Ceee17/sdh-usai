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
        ),
      ),
    );
  }
}

// PRIMARY BUTTON
Container PrimaryBtn(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: primaryBtnBox,
    child: Center(
      child: Text(
        text,
        style: primaryBtnText,
      ),
    ),
  );
}

Container PrimaryBtnDisabled(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: primaryBtnBoxisabled,
    child: Center(
      child: Text(
        text,
        style: primaryBtnTextDisabled,
      ),
    ),
  );
}

// PRIMARY BUTTON
Container PrimaryBtn(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: primaryBtnBox,
    child: Center(
      child: Text(
        text,
        style: primaryBtnText,
      ),
    ),
  );
}
