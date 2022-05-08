import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_onTap.dart';
import 'package:graceful_shop/screen/search/search.dart';
import 'package:graceful_shop/screen/tab_bar/tab_bar.dart';

class Action_Search extends StatelessWidget {
  const Action_Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Search(),
          ),
        );
      },
      icon: Icons.search,
      size: Dimensions.font27,
      border: false,
    );
  }
}

class Action_Cart extends StatelessWidget {
  const Action_Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {},
      icon: Icons.shopping_cart_outlined,
      size: Dimensions.font25,
      border: false,
    );
  }
}

class Action_Message extends StatelessWidget {
  const Action_Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOnTap1(
      onPressed: () {},
      icon: Icons.message_outlined,
      size: Dimensions.font25,
      border: false,
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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TabBarBottom(index: 0),
            ),
            (route) => false);
      },
      icon: Icons.home_outlined,
      size: Dimensions.font25,
      border: false,
    );
  }
}

List<Widget> lstAction1 = [
  const Action_Search(),
  const Action_Cart(),
  const Action_Message(),
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
