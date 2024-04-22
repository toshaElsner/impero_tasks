import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

/// Common widgets
class CommonWidgets {
  static const SizedBox sizedBox20 = SizedBox(height: 20);
  static const SizedBox sizedBox10 = SizedBox(height: 10);
  static const SizedBox sizedBoxW10 = SizedBox(width: 10);

  static Widget textWidget(String text, {FontWeight? fontWeight}) {
    return Text(text,
        style: TextStyle(
            fontSize: 18,
            color: AppColors.blackColor,
            fontWeight: fontWeight ?? FontWeight.normal));
  }

  static Widget smallTextWidget(String text, {FontWeight? fontWeight}) {
    return Text(text,
        style: TextStyle(
            fontSize: 12,
            color: AppColors.blackColor,
            fontWeight: fontWeight ?? FontWeight.normal));
  }
}
