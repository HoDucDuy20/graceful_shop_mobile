import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ListTileItem extends StatelessWidget {
  ListTileItem({Key? key, required this.title, required this.trailing,}) : super(key: key);
  String title;
  Widget trailing;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Dimensions.font17,
              fontWeight: FontWeight.w500,
              color: AppColors.black2Color,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
