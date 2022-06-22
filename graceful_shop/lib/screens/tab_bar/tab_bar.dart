// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:graceful_shop/screens/category/category.dart';
import 'package:graceful_shop/screens/favorite/favorite.dart';
import 'package:graceful_shop/screens/home/home.dart';
import 'package:graceful_shop/screens/personal_page/personal_page.dart';
import 'package:graceful_shop/screens/tab_bar/tab_icon.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class TabBarBottom extends StatefulWidget {
  int index = 0;
  TabBarBottom({Key? key, required this.index}) : super(key: key);

  @override
  State<TabBarBottom> createState() => _TabBarBottomState(index: index);
}

class _TabBarBottomState extends State<TabBarBottom> with SingleTickerProviderStateMixin {
  int index;
  TabController? tabController;
  _TabBarBottomState({this.tabController, required this.index});

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: index);
    tabController!.addListener((_handleTabSelection));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(30.0),
            //   topRight: Radius.circular(30.0),
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TabBar(
            indicatorWeight: 0,
            labelPadding: EdgeInsets.symmetric(vertical: Dimensions.h7),
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.mainColor,
                  width: 1.5,
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.mainColor,
            unselectedLabelColor: AppColors.grayColor,
            controller: tabController,
            tabs: [
              Tab(
                child: TabIcon(
                  assetIcon: 'assets/svg/icons/icon_home.svg',
                  tabController: tabController!,
                  index: 0,
                ),
              ),
              Tab(
                child: TabIcon(
                  assetIcon: 'assets/svg/icons/icon_menu.svg',
                  tabController: tabController!,
                  index: 1,
                ),
              ),
              Tab(
                child: TabIcon(
                  assetIcon: 'assets/svg/icons/icon_favorite.svg',
                  tabController: tabController!,
                  index: 2,
                ),
              ),
              Tab(
                child: TabIcon(
                  assetIcon: 'assets/svg/icons/icon_person.svg',
                  tabController: tabController!,
                  index: 3,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            Home(),
            Category(),
            Favorite(),
            PersonalPage(),
          ],
        ),
      ),
    );
  }
}
