import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/voucher_controller.dart';
import 'package:graceful_shop/controllers/address_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/list_tile_ontap.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/login/login.dart';
import 'package:graceful_shop/screens/personal_page/activity_diary.dart';
import 'package:graceful_shop/screens/personal_page/service.dart';
import 'package:graceful_shop/screens/personal_page_detail/personal_page_detail.dart';
import 'package:graceful_shop/screens/setting/setting.dart';
import 'package:graceful_shop/services/url.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  UserController userController = Get.find<UserController>();
  AddressController addressController = Get.find<AddressController>();
  VoucherController voucherController = Get.find<VoucherController>();

  @override
  void initState() {
    super.initState();
    userController.isLoading.value = false;
  }

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
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (userController.token.value != '')
                  Group(userController.user.value.fullName, userController.user.value.avatar)
                else
                  LoginRequired(),
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
                if (userController.token.value != '')
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
                    alignment: Alignment.center,
                    child: ButtonSignInUp(
                      isLoading: userController.isLoading.value,
                      onPressed: () {
                        showLogOut(() {
                          Get.back();
                          userController.logOut(context);
                        });
                      },
                      title: 'LogOut'.tr.toUpperCase(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget Name(String name) {
    return Text.rich(
      TextSpan(
        text: '${'Hello'.tr}\n',
        style: TextStyle(
          wordSpacing: 1.5,
          fontSize: Dimensions.font17,
          fontWeight: FontWeight.w500,
          color: AppColors.mainColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: name,
            style: TextStyle(
              height: 1.5,
              fontSize: Dimensions.font25,
              fontWeight: FontWeight.w600,
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
        InkWell(
          onTap: () {
            userController.getUserInfo();
            Get.to(const PersonalDetail(), duration: const Duration(milliseconds: 700), transition: Transition.upToDown);
          },
          child: Container(
            padding: EdgeInsets.only(top: Dimensions.h12, bottom: Dimensions.h5),
            alignment: Alignment.center,
            child: CircleAvatar(
                radius: Dimensions.w80,
                backgroundColor: AppColors.gray2Color,
                backgroundImage: (img == '')
                    ? Image.asset(
                        'assets/gif/loading_1.gif',
                        height: Dimensions.w250,
                        width: Dimensions.w250,
                      ).image
                    : DecorationImage(
                        image: FadeInImage.assetNetwork(
                          placeholder: 'assets/gif/loading_2.gif',
                          image: formaterImg(img),
                        ).image,
                        fit: BoxFit.cover,
                      ).image),
          ),
        ),
        Name(name),
        ActivityDiary(),
        const Service(),
        ListTileOnTap(
          onPressed: () {
            addressController.showAddress();
          },
          icon: Icons.book_outlined,
          title: 'AddressBook'.tr,
        ),
        ListTileOnTap(
          onPressed: () {
            voucherController.showVoucher();
          },
          icon: Icons.percent_outlined,
          title: 'Voucher'.tr,
        ),
      ],
    );
  }
}
