// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/cart_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_onTap.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/search/search.dart';
import 'package:graceful_shop/screens/tab_bar/tab_bar.dart';

CartController cartController = Get.find<CartController>();

Widget Action_Search() {
  return IconOnTap1(
    onPressed: () {
      Get.to(() => const Search());
    },
    icon: Icons.search,
    size: Dimensions.font27,
    color: AppColors.mainColor,
    border: false,
  );
}

Widget Action_Cart(bool border) {
  return IconOnTap1(
    onPressed: () async {
      cartController.showCart();
    },
    icon: Icons.shopping_cart_outlined,
    size: Dimensions.font25,
    color: AppColors.mainColor,
    border: border,
  );
}

Widget Action_Message(bool border) {
  return IconOnTap1(
    onPressed: () {
      showLogIn();
    },
    icon: Icons.message_outlined,
    size: Dimensions.font25,
    color: AppColors.mainColor,
    border: border,
  );
}

Widget Action_Shared(bool border) {
  return IconOnTap1(
    onPressed: () {
      showLogIn();
    },
    icon: Icons.share_rounded,
    size: Dimensions.font25,
    color: AppColors.mainColor,
    border: border,
  );
}

Widget Action_Notification() {
  return IconOnTap1(
    onPressed: () {},
    icon: Icons.notifications_outlined,
    size: Dimensions.font25,
    color: AppColors.mainColor,
    border: false,
  );
}

Widget Action_Home() {
  return IconOnTap1(
    onPressed: () {
      Get.offAll(() => TabBarBottom(index: 0));
    },
    icon: Icons.home_outlined,
    size: Dimensions.font25,
    color: AppColors.mainColor,
    border: false,
  );
}

List<Widget> lstAction1 = [
  Action_Search(),
  Action_Cart(false),
  Action_Message(false),
  SizedBox(
    width: Dimensions.w15,
  )
];

List<Widget> lstAction2 = [
  Action_Notification(),
  Action_Home(),
  SizedBox(
    width: Dimensions.w15,
  )
];

List<Widget> lstAction3 = [
  Action_Cart(true),
  Action_Shared(true),
];
