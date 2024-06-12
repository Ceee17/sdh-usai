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
class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.label, this.onPressed, this.color});
  final String label;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: primaryBtnText,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return color;
            }
            return color;
          },
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(double.infinity, 50),
        ),
      ),
    );
  }
}
