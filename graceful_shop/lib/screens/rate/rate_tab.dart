import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/screens/invoice/tab_text.dart';
import 'package:graceful_shop/screens/rate/rate_screen.dart';
import 'package:graceful_shop/screens/rate/rated_screen.dart';

class RateTab extends StatefulWidget {
  const RateTab({Key? key}) : super(key: key);

  @override
  State<RateTab> createState() => _RateTabState();
}

class _RateTabState extends State<RateTab> with SingleTickerProviderStateMixin {
  _RateTabState({this.tabController});
  TabController? tabController;
  RateController rateController = Get.find<RateController>();


  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController!.addListener((_handleTabSelection));
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white3Color,
          foregroundColor: AppColors.mainColor,
          shadowColor: AppColors.whiteColor,
          elevation: 0.5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                  child: Icon(
                    Icons.chevron_left,
                    size: Dimensions.font30,
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              Text(
                'Rate'.tr,
                style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorWeight: 0,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
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
                child: TabText(
                  title: 'NotYetRated'.tr,
                  tabController: tabController!,
                  index: 0,
                ),
              ),
              Tab(
                child: TabText(
                  title: 'Rated'.tr,
                  tabController: tabController!,
                  index: 1,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            RateScreen(listProductRate: rateController.productNotYedRatedList),
            RatedScreen(listProductRate: rateController.productRatedList),
          ],
        ),
      ),
    );
  }
}