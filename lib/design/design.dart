import 'package:flutter/material.dart';

// Colouring
Color primaryColor = Color(0xFFFFA62F);
Color white = Colors.white;
Color grey = Colors.grey;
Color grey600 = Colors.grey.shade600;
Color black = Colors.black;
Color red = Colors.red;
Color green = Colors.green;
Color blue = Colors.blue;

// TextStyling
TextStyle appBar = TextStyle(
  // fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle startingText(double size, FontWeight fw) {
  return TextStyle(
    fontSize: size,
    fontWeight: fw,
    fontFamily: "Poppins",
    color: black,
  );
}

TextStyle copyrightText = TextStyle(
  fontSize: 12,
  color: Colors.grey,
  fontFamily: "Poppins",
);

TextStyle customText(double size, FontWeight weight, Color color) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}

TextStyle headerText(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
  );
}

TextStyle cardText = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

TextStyle clipText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle primaryBtnText = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: white,
);

TextStyle primaryBtnTextDisabled = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: white.withOpacity(0.5),
);

TextStyle priceText = TextStyle(
  fontSize: 16,
  color: grey600,
);

TextStyle descText = TextStyle(
  fontSize: 14,
  color: grey600,
);

TextStyle warningText = TextStyle(
  fontSize: 18,
  color: red,
  fontWeight: FontWeight.bold,
);

TextStyle linkText = TextStyle(
  color: blue,
  decoration: TextDecoration.underline,
);

TextStyle labelText = TextStyle(
  // fontSize: ,
  fontWeight: FontWeight.w400,
);

// Jarak SizedBox
SizedBox h(double t) {
  return SizedBox(
    height: t,
  );
}

SizedBox w(double l) {
  return SizedBox(
    width: l,
  );
}

// BoxStyling
BoxDecoration warningBox = BoxDecoration(
  color: Colors.red[100],
  borderRadius: BorderRadius.circular(8.0),
);

BoxDecoration primaryBtnBox = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(90),
);

BoxDecoration primaryBtnBoxisabled = BoxDecoration(
  color: primaryColor.withOpacity(0.5),
  borderRadius: BorderRadius.circular(90),
);

// GridStyling
SliverGridDelegateWithFixedCrossAxisCount GridFixedCrossAxisCount(
    int cAC, double cAR, double cAS, double mAS) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: cAC,
    childAspectRatio: cAR,
    crossAxisSpacing: cAS,
    mainAxisSpacing: mAS,
  );
}
