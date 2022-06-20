import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/screens/login/login.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class LinkLogin extends StatelessWidget {
  const LinkLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
      child: Text.rich(
        TextSpan(
          text: '${'IfAccount'.tr}\n',
          style: TextStyle(
            fontSize: Dimensions.font16,
            color: AppColors.black2Color,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '${'Here'.tr} ',
              style: TextStyle(
                fontSize: Dimensions.font16,
                color: AppColors.mainColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                  Get.off(() => const Login());
                },
            ),
            TextSpan(
              text: 'ToLogin'.tr,
              style: TextStyle(
                fontSize: Dimensions.font16,
                color: AppColors.black2Color,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
