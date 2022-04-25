import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

class HeaderLoginRegister extends StatelessWidget {
  String title;
  String subTitle;
  HeaderLoginRegister({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.h40, left: Dimensions.w35),
      margin: EdgeInsets.only(bottom: Dimensions.h40),
      height: Dimensions.h200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(70)),
        color: AppColors.mainColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.h50,
                width: Dimensions.w50,
                child: SvgPicture.asset(
                  'assets/svg/logo.svg',
                  color: AppColors.whiteColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.font40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    color: AppColors.whiteColor,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}