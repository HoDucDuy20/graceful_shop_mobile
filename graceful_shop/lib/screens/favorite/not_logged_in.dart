import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/screens/login/login.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h30),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.h250,
            width: Dimensions.w250,
            child: const Image(
              image: AssetImage('assets/images/login_request.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h30),
            child: Text(
              'NotLoggedIn'.tr,
              style: TextStyle(
                fontSize: Dimensions.font27,
                fontWeight: FontWeight.w500,
                color: AppColors.black2Color,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w30),
            child: Text(
              'SignInRequired'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w400,
                color: AppColors.black2Color,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimensions.h30),
            child: ButtonSignInUp(
              title: 'Login'.tr,
              onPressed: () {
                Get.to(() => const Login());
              },
            ),
          ),
        ],
      ),
    );
  }
}
