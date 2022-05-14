import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class NoProduct extends StatelessWidget {
  const NoProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h30),
          child: Text(
            'NoProduct'.tr,
            style: TextStyle(
              fontSize: Dimensions.font27,
              fontWeight: FontWeight.w500,
              color: AppColors.black2Color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w30),
          child: Text(
            'TitleAddProduct'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimensions.font20,
              fontWeight: FontWeight.w400,
              color: AppColors.black2Color,
            ),
          ),
        ),
      ],
    );
  }
}
