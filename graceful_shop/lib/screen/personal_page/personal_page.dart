import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/list_tile_ontap.dart';
import 'package:graceful_shop/screen/personal_page/activity_diary.dart';
import 'package:graceful_shop/screen/personal_page/service.dart';
import 'package:graceful_shop/screen/setting/setting.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.w25,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white3Color,
        foregroundColor: AppColors.mainColor,
        shadowColor: AppColors.whiteColor,
        elevation: 0.5,
        title: Text(
          'PersonalPage'.tr,
          style: TextStyle(
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: lstAction2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: Dimensions.h12, bottom: Dimensions.h5),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: Dimensions.w80,
                  backgroundColor: AppColors.white2Color,
                  backgroundImage: AssetImage('assets/images/img_1.jpg'),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Hello'.tr + '\n',
                  style: TextStyle(
                    wordSpacing: 1.5,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Hồ Đức Duy',
                      style: TextStyle(
                        height: 1.5,
                        fontSize: Dimensions.font25,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
              ActivityDiary(),
              Service(),
              ListTileOnTap(
                onPressed: () {},
                icon: Icons.book_outlined,
                title: 'Address'.tr,
              ),
              ListTileOnTap(
                onPressed: () {},
                icon: Icons.percent_outlined,
                title: 'Voucher'.tr,
              ),
              ListTileOnTap(
                onPressed: () {},
                icon: Icons.policy_outlined,
                title: 'Policy'.tr,
              ),
              ListTileOnTap(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
                icon: Icons.settings_outlined,
                title: 'Setting'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
