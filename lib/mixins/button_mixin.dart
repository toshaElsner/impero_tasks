import 'package:flutter/material.dart';

import '../utils/colors.dart';

/// Button Mixin
mixin BlackRoundedButtonMixin {
  Widget getBlackRoundedButton(
      {@required String? text,
      @required VoidCallback? onPressed,
      @required double? borderRadius,
      @required double? width,
      @required double? height}) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blackColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        child: Text(text!, style: const TextStyle(color: AppColors.whiteColor)),
      ),
    );
  }
}
