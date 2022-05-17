import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/button_sign_in_up.dart';
import 'package:graceful_shop/resources/widgets/list_tile_ontap.dart';
import 'package:graceful_shop/screens/login/login.dart';
import 'package:graceful_shop/screens/personal_page/activity_diary.dart';
import 'package:graceful_shop/screens/personal_page/service.dart';
import 'package:graceful_shop/screens/setting/setting.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  String Token = '';

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
              if (Token.isEmpty)
                Group('Hồ Đức Duy', 'assets/images/img_1.jpg')
              else
                LoginRequired(),
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
                  Get.to(() => const Setting());
                },
                icon: Icons.settings_outlined,
                title: 'Setting'.tr,
              ),
              if (Token.isEmpty)
                Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
                  alignment: Alignment.center,
                  child: ButtonSignInUp(
                    onPressed: () {},
                    title: 'LogOut'.tr.toUpperCase(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Name(String name) {
    return Text.rich(
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
            text: name,
            style: TextStyle(
              height: 1.5,
              fontSize: Dimensions.font25,
              color: AppColors.black2Color,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget LoginRequired() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: Dimensions.h12, bottom: Dimensions.h5),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: Dimensions.w80,
            backgroundColor: AppColors.blueAccentSearchColor,
            child: SizedBox(
              height: Dimensions.h100,
              width: Dimensions.w80,
              child: SvgPicture.asset(
                'assets/svg/icons/icon_person.svg',
                color: AppColors.white3Color,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.h5, bottom: Dimensions.h7),
          child: ButtonSignInUp(
            onPressed: () {
              Get.to(() => const Login());
            },
            title: 'Login'.tr.toUpperCase(),
          ),
        ),
      ],
    );
  }

  Widget Group(String name, String img) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(top: Dimensions.h12, bottom: Dimensions.h5),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: Dimensions.w80,
            backgroundColor: AppColors.white2Color,
            backgroundImage: AssetImage(img),
          ),
        ),
        Name('Hồ Đức Duy'),
        ActivityDiary(),
        Service(),
      ],
    );
  }
}
