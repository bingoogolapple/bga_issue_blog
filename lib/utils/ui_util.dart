import 'package:flutter/material.dart';

abstract class UIUtil {
  static final webStyleWidth = 768;

  static isPhoneStyle(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < webStyleWidth;
  }
}
