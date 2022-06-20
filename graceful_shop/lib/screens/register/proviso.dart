import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class Proviso extends StatelessWidget {
  const Proviso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h12),
      child: Text.rich(
        TextSpan(
          text: '${'YouAgree'.tr}\n',
          style: TextStyle(
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w600,
            color: AppColors.black2Color,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Terms'.tr,
              style: TextStyle(
                fontSize: Dimensions.font16,
                color: AppColors.mainColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
