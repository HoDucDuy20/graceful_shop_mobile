// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class HeaderLoginRegister extends StatelessWidget {
  HeaderLoginRegister({Key? key, required this.title, required this.subTitle}) : super(key: key);
  String title;
  String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.h40, left: Dimensions.w35, bottom: Dimensions.h10),
      margin: EdgeInsets.only(bottom: Dimensions.h40),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(70)),
        color: AppColors.mainColor,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Dimensions.width - Dimensions.w35,
                child: Column(
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
                          fontSize: Dimensions.font35,
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
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: Dimensions.w20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.clear_rounded,
                    size: Dimensions.font30,
                    color: AppColors.grayColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
