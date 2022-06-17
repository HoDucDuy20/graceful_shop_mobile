import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/screens/register/register.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class LinkRegister extends StatelessWidget {
  const LinkRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${'IfNotAccount'.tr}\n',
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
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.off(() => const Register());
              },
          ),
          TextSpan(
            text: 'ToRegister'.tr,
            style: TextStyle(
              fontSize: Dimensions.font16,
              color: AppColors.black2Color,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
