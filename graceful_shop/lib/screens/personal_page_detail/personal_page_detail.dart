import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/screens/personal_page_detail/password_edit.dart';
import 'package:graceful_shop/screens/personal_page_detail/personal_page_edit.dart';
import 'package:graceful_shop/services/url.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({Key? key}) : super(key: key);

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  UserController userController = Get.find<UserController>();

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
              'PersonalPageInfo'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Dimensions.w15),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: Dimensions.h10),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: Dimensions.w100,
                    backgroundColor: AppColors.gray2Color,
                    backgroundImage: FadeInImage.assetNetwork(
                      placeholder: 'assets/gif/loading_2.gif',
                      image: formaterImg(userController.user.value.avatar),
                    ).image,
                  ),
                ),
                title('PersonalPageInfo'.tr),
                info('InputName'.tr, userController.user.value.fullName),
                info('DateOfBirth'.tr, Format.date(userController.user.value.dateOfBirth)),
                info('Sex'.tr, userController.user.value.sexName),
                title('AccountInformation'.tr),
                if(userController.user.value.typeLogin == 0)
                  info('Phone'.tr, userController.user.value.phone),
                info('Email'.tr, userController.user.value.email),
                // info('Address'.tr, userController.user.value.address),
                if(userController.user.value.typeLogin == 0)
                  InkWell(
                    onTap: (){
                      Get.to(() => const PasswordEdit());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.w10),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                      color: AppColors.gray2Color,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text(
                          'InputPass'.tr,
                          style: TextStyle(
                            wordSpacing: 1.5,
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black2Color,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_right,
                        ),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.all(Dimensions.w20),
                  alignment: Alignment.center,
                  child: ButtonAddCart(
                    title: 'Edit'.tr,
                    onPressed: () {
                      Get.to(() => const PersonalEdit());
                    },
                    color: AppColors.red3Color,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

Widget title(String title) {
  return Padding(
    padding: EdgeInsets.only(top: Dimensions.h10),
    child: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: Dimensions.font17,
        fontWeight: FontWeight.w600,
        color: AppColors.black2Color,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget info(String infoNname, String info) {
  return Padding(
    padding: EdgeInsets.all(Dimensions.w10),
    child: Text.rich(
      TextSpan(
        text: '$infoNname: ',
        style: TextStyle(
          wordSpacing: 1.5,
          fontSize: Dimensions.font16,
          fontWeight: FontWeight.w400,
          color: AppColors.black2Color,
        ),
        children: <TextSpan>[
          TextSpan(
            text: info,
            style: TextStyle(
              height: 1.5,
              fontSize: Dimensions.font17,
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    ),
  );
}
