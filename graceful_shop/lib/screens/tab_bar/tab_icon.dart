// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class TabIcon extends StatelessWidget {
  String assetIcon;
  TabController tabController;
  int index;
  TabIcon({Key? key, required this.assetIcon, required this.tabController, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetIcon,
          color: tabController.index == index ? AppColors.mainColor : AppColors.grayColor,
          height: Dimensions.h25,
          width: Dimensions.w25,
        ),
      ],
    );
  }
}
