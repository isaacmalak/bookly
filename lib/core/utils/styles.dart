import 'package:flutter/material.dart';

abstract class Styles {
  static final textFine = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.5),
  );
  static const textRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const textBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );
  static const textMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );
  static const titleMedium = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
}
