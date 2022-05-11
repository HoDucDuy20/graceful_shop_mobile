import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_onTap.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screen/search/search.dart';
import 'package:graceful_shop/screen/tab_bar/tab_bar.dart';

class Action_Search extends StatelessWidget {
  const Action_Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {
        Get.to(() => const Search());
      },
      icon: Icons.search,
      size: Dimensions.font27,
      border: false,
    );
  }
}

class Action_Cart extends StatelessWidget {
  bool border;
  Action_Cart({Key? key, required this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () async {
        showLogIn();
      },
      icon: Icons.shopping_cart_outlined,
      size: Dimensions.font25,
      border: border,
    );
  }
}

class Action_Message extends StatelessWidget {
  bool border;
  Action_Message({Key? key, required this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {
        showLogIn();
      },
      icon: Icons.message_outlined,
      size: Dimensions.font25,
      border: border,
    );
  }
}

class Action_Notification extends StatelessWidget {
  const Action_Notification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {},
      icon: Icons.notifications_outlined,
      size: Dimensions.font25,
      border: false,
    );
  }
}

class Action_Home extends StatelessWidget {
  const Action_Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {
        Get.offAll(() => TabBarBottom(index: 0));
      },
      icon: Icons.home_outlined,
      size: Dimensions.font25,
      border: false,
    );
  }
}

List<Widget> lstAction1 = [
  const Action_Search(),
  Action_Cart(border: false),
  Action_Message(border: false),
  SizedBox(
    width: Dimensions.w15,
  )
];

List<Widget> lstAction2 = [
  const Action_Notification(),
  const Action_Home(),
  SizedBox(
    width: Dimensions.w15,
  )
];
