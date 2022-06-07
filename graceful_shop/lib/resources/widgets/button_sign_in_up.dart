// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ButtonSignInUp extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  
  ButtonSignInUp({Key? key, required this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      color: AppColors.mainColor,
      height: Dimensions.h40,
      minWidth: Dimensions.w210,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: Dimensions.font20,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
