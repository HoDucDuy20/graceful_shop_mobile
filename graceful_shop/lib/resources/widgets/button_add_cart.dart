// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ButtonAddCart extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  Color color;

  ButtonAddCart(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      color: color,
      height: Dimensions.h40,
      minWidth: Dimensions.width / 2.4,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontSize: Dimensions.font15,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
