import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/icon_ontap.dart';

class ActivityDiary extends StatelessWidget {
  const ActivityDiary({Key? key}) : super(key: key);

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
              color: AppColors.blackColor,
              size: Dimensions.font30,
            ),
            title: Text(
              'ActivityDiary'.tr,
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconOnTap2(
                onPressed: () {},
                icon: Icons.history_edu_outlined,
                title: 'OrderHistory'.tr,
              ),
              IconOnTap2(
                onPressed: () {},
                icon: Icons.event_note_outlined,
                title: 'OrderStatus'.tr,
              ),
            ],
          )
        ],
      ),
    );
  }
}
