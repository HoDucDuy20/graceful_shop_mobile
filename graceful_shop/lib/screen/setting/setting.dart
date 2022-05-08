import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/multiple_language/localization_service.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screen/setting/list_tile.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<Widget> lstItem = [];
  String langCode = LocalizationService.langCodeValue;
  _loadListItem() {
    LocalizationService.langs.forEach((key, value) {
      lstItem.add(
        InkWell(
          onTap: () {
            setState(() {
              langCode = key;
            });
            LocalizationService.changeLocale(key);
            Navigator.pop(context);
          },
          child: ListTileItem(
            title: value,
            trailing: SizedBox(
              height: Dimensions.h25,
              width: Dimensions.w25,
              child: SvgPicture.asset('assets/svg/$key.svg'),
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
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                child: Icon(
                  Icons.chevron_left,
                  size: Dimensions.font40,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            Text(
              'Setting'.tr,
              style: TextStyle(
                fontSize: Dimensions.font25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: lstAction2,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.w20, vertical: Dimensions.h10),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
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
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white,
                      title: Center(
                        child: Text(
                          "Cài đặt ngôn ngữ",
                          style: TextStyle(
                            fontSize: Dimensions.font17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: lstItem,
                      ),
                      // actions: [
                      //   Align(
                      //     alignment: Alignment.center,
                      //     child: OutlinedButton(
                      //       child: Text("Cancel".tr),
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //     ),
                      //   )
                      // ],
                    ),
                  );
                },
                child: ListTileItem(
                  title: 'Language'.tr,
                  trailing: SizedBox(
                    height: Dimensions.h25,
                    width: Dimensions.w25,
                    child: SvgPicture.asset('assets/svg/$langCode.svg'),
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
