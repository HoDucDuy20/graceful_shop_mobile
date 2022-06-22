import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_ontap.dart';
import 'package:graceful_shop/screens/feedback/feedback.dart';

class Service extends StatelessWidget {
  const Service({Key? key}) : super(key: key);

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
              Icons.flip_to_back_outlined,
              color: AppColors.black2Color,
              size: Dimensions.font30,
            ),
            title: Text(
              'Service'.tr,
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
                  Get.to(() => const FeedbackScreen());
                },
                icon: Icons.feedback_outlined,
                title: 'Feedback'.tr,
              ),
              IconOnTap2(
                onPressed: () {},
                icon: Icons.share_outlined,
                title: 'Share'.tr,
              ),
            ],
          )
        ],
      ),
    );
  }
}
