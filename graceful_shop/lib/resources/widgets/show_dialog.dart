import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
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
        padding: EdgeInsets.symmetric(vertical: Dimensions.h12, horizontal: Dimensions.w15),
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

void showLogOut(VoidCallback f) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h12, horizontal: Dimensions.w15),
        child: Text(
          'LogOut'.tr,
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
          'DoYouWantSignOut'.tr,
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
                onPressed: f,
                child: Text(
                  'LogOut'.tr,
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

void showSuccess(String title) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(Dimensions.w30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.done,
              size: 30,
              color: AppColors.greenColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: Dimensions.font14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void confirmDelete(int index) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(top: Dimensions.h7),
      actionsPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h10, horizontal: Dimensions.w25),
        child: Text(
          'AreYouSureQuitProduct'.tr,
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
                  'No'.tr,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {                  
                  cartController.productCartList[index].quantity--;
                  cartController.updateCart(index);
                  Get.back();
                },
                child: Text(
                  'Yes'.tr,
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
