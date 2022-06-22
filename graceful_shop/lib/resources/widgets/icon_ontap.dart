// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class IconOnTap1 extends StatelessWidget {
  IconOnTap1({Key? key, required this.onPressed, required this.icon, required this.size, required this.border, required this.color}) : super(key: key);
  VoidCallback onPressed;
  IconData icon;
  double size;
  bool border;
  Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.noneColor,
      splashColor: AppColors.noneColor,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(Dimensions.h7),
        margin: EdgeInsets.only(left: Dimensions.w5),
        decoration: border
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white2Color,
              )
            : null,
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}

class IconOnTap2 extends StatelessWidget {
  IconOnTap2({Key? key, required this.onPressed, required this.icon, required this.title}) : super(key: key);
  VoidCallback onPressed;
  IconData icon;
  String title;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.noneColor,
      splashColor: AppColors.noneColor,
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: AppColors.grayColor,
            size: Dimensions.font30,
          ),
          Text(
            title,
            style: TextStyle(
              height: 1.3,
              fontSize: Dimensions.font16,
              fontWeight: FontWeight.w500,
              color: AppColors.black2Color,
            ),
          ),
        ],
      ),
    );
  }
}


