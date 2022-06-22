import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/screens/invoice/invoice_screen.dart';
import 'package:graceful_shop/screens/invoice/tab_text.dart';

class InvoiceTab extends StatefulWidget {
  const InvoiceTab({Key? key}) : super(key: key);

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> with SingleTickerProviderStateMixin {
  _InvoiceTabState({this.tabController});
  TabController? tabController;
  InvoiceController invoiceController = Get.find<InvoiceController>();


  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    tabController!.addListener((_handleTabSelection));
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
                'Invoice'.tr,
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
                  title: 'WaitForConfirmation'.tr,
                  tabController: tabController!,
                  index: 0,
                ),
              ),
              Tab(
                child: TabText(
                  title: 'Confirmed'.tr,
                  tabController: tabController!,
                  index: 1,
                ),
              ),
              Tab(
                child: TabText(
                  title: 'Delivering'.tr,
                  tabController: tabController!,
                  index: 2,
                ),
              ),
              Tab(
                child: TabText(
                  title: 'Delivered'.tr,
                  tabController: tabController!,
                  index: 3,
                ),
              ),
              Tab(
                child: TabText(
                  title: 'Canceled'.tr,
                  tabController: tabController!,
                  index: 4,
                ),
              ),
            ],
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            InvoiceScreen(listInvoice: invoiceController.waitForConfirmationList),
            InvoiceScreen(listInvoice: invoiceController.confirmedList),
            InvoiceScreen(listInvoice: invoiceController.deliveringList),
            InvoiceScreen(listInvoice: invoiceController.deliveredList),
            InvoiceScreen(listInvoice: invoiceController.cancelList),
          ],
        ),
      ),
    );
  }
}