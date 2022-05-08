import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ListTileOnTap extends StatelessWidget {
  VoidCallback onPressed;
  IconData icon;
  String title;
  ListTileOnTap({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
  }) : super(key: key);
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
            color: AppColors.blackColor,
            size: Dimensions.font30,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: Dimensions.font16,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
          ),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}