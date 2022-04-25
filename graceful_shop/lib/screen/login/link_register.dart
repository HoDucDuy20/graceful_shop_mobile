import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graceful_shop/screen/register/register.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

class LinkRegister extends StatelessWidget {
  const LinkRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Nếu bạn chưa có tài khoản vui lòng nhấn\n',
        style: TextStyle(
          fontSize: Dimensions.font16,
          color: AppColors.blackColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'vào đây ',
            style: TextStyle(
              fontSize: Dimensions.font16,
              color: AppColors.mainColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
          ),
          TextSpan(
            text: 'để đăng ký',
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
