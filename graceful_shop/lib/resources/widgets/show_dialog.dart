import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/info_shop_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screens/login/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

InfoShopController infoShopController = Get.find<InfoShopController>();

void _launchUrl(String url) async {
  // Uri _url = Uri.parse(url);
  // print(_url);
  // if (!await launchUrl(_url)) throw 'Could not launch $_url';
  try {
    // ignore: deprecated_member_use
    await launch(url, forceSafariVC: false, forceWebView: false);
    print(url);
  } catch (e) {
    print("error laucher mess");
  }
}


void showLogIn() async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h12, horizontal: Dimensions.w15),
        child: Text(
          'Login'.tr,
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
        child: Text(
          'PleaseLogIn'.tr,
          style: TextStyle(
            color: AppColors.black2Color,
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(() => const Login());
                },
                child: Text(
                  'Login'.tr,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showLanguage(List<Widget> lstItem) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w25),
      actionsPadding: EdgeInsets.zero,
      title: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(bottom: Dimensions.h10),
        child: Text(
          'LanguageSettings'.tr,
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: SizedBox(
        height: Dimensions.height / 4,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: lstItem,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(Dimensions.h5),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Text(
              'Cancel'.tr,
              style: TextStyle(
                color: AppColors.grayColor,
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void showLogOut(VoidCallback f) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h12, horizontal: Dimensions.w15),
        child: Text(
          'LogOut'.tr,
          style: TextStyle(
            color: AppColors.mainColor,
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
        child: Text(
          'DoYouWantSignOut'.tr,
          style: TextStyle(
            color: AppColors.black2Color,
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: f,
                child: Text(
                  'LogOut'.tr,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showSuccess(String title) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(Dimensions.w30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.done,
              size: 30,
              color: AppColors.greenColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: Dimensions.font14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showSuccess2(String title, String subtitle) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.w30),
        padding: EdgeInsets.only(top: Dimensions.w30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.done,
              size: 30,
              color: AppColors.greenColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: Dimensions.font16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.black2Color,
                fontSize: Dimensions.font14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.w5),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Text(
                'Ok'.tr,
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: Dimensions.font17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void confirmDelete(int index) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(top: Dimensions.h7),
      actionsPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h10, horizontal: Dimensions.w25),
        child: Text(
          'AreYouSureQuitProduct'.tr,
          style: TextStyle(
            color: AppColors.black2Color,
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'No'.tr,
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {                  
                  cartController.productCartList[index].quantity--;
                  cartController.updateCart(index);
                  Get.back();
                },
                child: Text(
                  'Yes'.tr,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void showInfoShop() async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
      actionsPadding: EdgeInsets.zero,
      title: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(bottom: Dimensions.h10),
        child: Text(
          'InfoShop'.tr,
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      content: SizedBox(
        height: Dimensions.height / 3,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.gray3Color,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: Dimensions.w15),
                  title: Text(
                    'Address'.tr,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    infoShopController.infoShop.value.address,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: Dimensions.font14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      _launchUrl(infoShopController.infoShop.value.addressMap);
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: Dimensions.font25,
                      color: AppColors.orangeColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: AppColors.gray3Color,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: Dimensions.w15),
                  title: Text(
                    'Phone'.tr,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    infoShopController.infoShop.value.phone,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: Dimensions.font14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: (){
                      _launchUrl('tel://${infoShopController.infoShop.value.phone}');
                    },
                    icon: Icon(
                      Icons.phone_outlined,
                      size: Dimensions.font25,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: AppColors.gray3Color,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: Dimensions.w15),
                  title: Text(
                    'Chat'.tr,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // subtitle: Text(
                  //   infoShopController.infoShop.value.phone,
                  //   style: TextStyle(
                  //     color: AppColors.blackColor,
                  //     fontSize: Dimensions.font14,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  trailing: IconButton(
                    onPressed: (){
                      _launchUrl(infoShopController.infoShop.value.messChat);
                    },
                    icon: Icon(
                      Icons.message_outlined,
                      size: Dimensions.font25,
                      color: AppColors.red3Color,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                color: AppColors.gray3Color,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: Dimensions.w15),
                  title: Text(
                    'Fanpage'.tr,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // subtitle: Text(
                  //   infoShopController.infoShop.value.phone,
                  //   style: TextStyle(
                  //     color: AppColors.blackColor,
                  //     fontSize: Dimensions.font14,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  trailing: IconButton(
                    onPressed: (){
                      _launchUrl(infoShopController.infoShop.value.pageFb.replaceAll("https://www.facebook.com/", "https://www.facebook.com/"));
                    },
                    icon: Icon(
                      Icons.facebook_outlined,
                      size: Dimensions.font25,
                      color: AppColors.blueColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(Dimensions.h5),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Ok'.tr,
                style: TextStyle(
                  color: AppColors.grayColor,
                  fontSize: Dimensions.font16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



// void toastSuccess2(String message) {
//   FToast fToast = FToast();
//   return fToast.showToast(
//     child: Container(
//       padding: EdgeInsets.all(Dimensions.w30),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.done,
//             size: Dimensions.font27,
//             color: AppColors.greenColor,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             message,
//             style: TextStyle(
//               color: AppColors.mainColor,
//               fontSize: Dimensions.font14,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     ),
//     gravity: ToastGravity.CENTER,
//     toastDuration: const Duration(seconds: 2),
//   );
// }

void toastSuccess(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: AppColors.gray2Color,
    textColor: AppColors.greenColor,
    fontSize: Dimensions.font15,
  );
}