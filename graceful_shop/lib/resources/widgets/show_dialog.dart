import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/screens/login/login.dart';

void showLogIn() async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.h12, horizontal: Dimensions.w15),
        child: Text(
          'Login'.tr,
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
        child: Text(
          'PleaseLogIn'.tr,
          style: TextStyle(
            color: AppColors.black2Color,
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => const Login());
                },
                child: Text(
                  'Login'.tr,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showLanguage(List<Widget> lstItem) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w25),
      actionsPadding: EdgeInsets.zero,
      title: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(bottom: Dimensions.h10),
        child: Text(
          'LanguageSettings'.tr,
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: SizedBox(
        height: Dimensions.height / 2,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: lstItem,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(Dimensions.h5),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Text(
              'Cancel'.tr,
              style: TextStyle(
                color: AppColors.grayColor,
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}