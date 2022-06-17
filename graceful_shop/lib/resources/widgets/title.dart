import 'package:flutter/cupertino.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

Widget titleProductDetail(String title) {
  return Container(
    width: Dimensions.width,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: AppColors.gray2Color,
          width: 10.0,
        ),
      ),
    ),
    margin: EdgeInsets.only(top: Dimensions.h10),
    padding: EdgeInsets.only(top: Dimensions.h10, bottom: Dimensions.h12),
    child: Text(
      title,
      style: TextStyle(
        fontSize: Dimensions.font16,
        fontWeight: FontWeight.w600,
        color: AppColors.black2Color,
        letterSpacing: 0.5,
      ),
    ),
  );
}
