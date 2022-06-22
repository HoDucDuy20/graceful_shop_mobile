import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_ontap.dart';

class ActivityDiary extends StatelessWidget {
  ActivityDiary({Key? key}) : super(key: key);
  InvoiceController invoiceController = Get.find<InvoiceController>();
  RateController rateController = Get.find<RateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grayColor,
            width: 0.3,
          ),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: Icon(
              Icons.av_timer_outlined,
              color: AppColors.black2Color,
              size: Dimensions.font30,
            ),
            title: Text(
              'ActivityDiary'.tr,
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w500,
                color: AppColors.black2Color,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconOnTap2(
                onPressed: () {
                  invoiceController.showInvoice();
                },
                icon: Icons.history_edu_outlined,
                title: 'OrderHistory'.tr,
              ),
              IconOnTap2(
                onPressed: () {
                  rateController.showRate();
                },
                icon: Icons.rate_review_outlined,
                title: 'MyRate'.tr,
              ),
            ],
          )
        ],
      ),
    );
  }
}
