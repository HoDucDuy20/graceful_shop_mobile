import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/screen/register/register.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class LinkRegister extends StatelessWidget {
  const LinkRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'If_Not_Account'.tr + '\n',
        style: TextStyle(
          fontSize: Dimensions.font16,
          color: AppColors.blackColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Here'.tr + ' ',
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
            text: 'To_Register'.tr,
            style: TextStyle(
              fontSize: Dimensions.font16,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
