// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class TabText extends StatelessWidget {
  String title;
  TabController tabController;
  int index;
  TabText({Key? key, required this.title, required this.tabController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Dimensions.font15,
        fontWeight: FontWeight.w500,
        color: tabController.index == index ? AppColors.mainColor : AppColors.black2Color,
        letterSpacing: 0.5,
      ),
    );
  }
}
