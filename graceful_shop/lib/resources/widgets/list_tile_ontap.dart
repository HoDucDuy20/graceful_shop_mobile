// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ListTileOnTap extends StatelessWidget {
  ListTileOnTap({Key? key, required this.onPressed, required this.icon, required this.title}) : super(key: key);
  VoidCallback onPressed;
  IconData icon;
  String title;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grayColor,
              width: 0.3,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          leading: Icon(
            icon,
            color: AppColors.black2Color,
            size: Dimensions.font30,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: Dimensions.font16,
              fontWeight: FontWeight.w500,
              color: AppColors.black2Color,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
