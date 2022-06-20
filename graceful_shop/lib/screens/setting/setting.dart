import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/multiple_language/localization_service.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/personal_page_detail/personal_page_detail.dart';
import 'package:graceful_shop/screens/setting/list_tile.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  UserController userController = Get.find<UserController>();
  List<Widget> lstItem = [];
  String langCode = LocalizationService.langCodeValue;
  
  _loadListItem() {
    LocalizationService.langs.forEach((key, value) {
      lstItem.add(
        InkWell(
          onTap: () {
            setState(() {});
            langCode = key;
            LocalizationService.changeLocale(key);
            Get.back();
          },
          child: ListTileItem(
            title: value,
            trailing: SizedBox(
              height: Dimensions.h25,
              width: Dimensions.w25,
              child: SvgPicture.asset('assets/svg/langs/$key.svg'),
            ),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _loadListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Setting'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        // actions: lstAction2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w20, vertical: Dimensions.h10),
          child: Column(
            children: [
              if (userController.token.value != '')
                InkWell(
                  onTap: () {
                    userController.getUserInfo();
                    Get.to(() => const PersonalDetail());
                  },
                  child: ListTileItem(
                    title: 'Infor'.tr,
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ListTileItem(
                title: 'Version'.tr,
                trailing: Text(
                  'V1.0',
                  style: TextStyle(
                    letterSpacing: 2.5,
                    fontSize: Dimensions.font15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showLanguage(lstItem);
                },
                child: ListTileItem(
                  title: 'Language'.tr,
                  trailing: SizedBox(
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                    child: SvgPicture.asset('assets/svg/langs/$langCode.svg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
