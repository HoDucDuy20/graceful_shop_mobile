import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graceful_shop/screen/login/login.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

class LinkLogin extends StatelessWidget {
  const LinkLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
      child: Text.rich(
        TextSpan(
          text: 'Nếu bạn đã có tài khoản vui lòng nhấn\n',
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
                      builder: (context) => const Login(),
                    ),
                  );
                },
            ),
            TextSpan(
              text: 'để đăng nhập',
              style: TextStyle(
                fontSize: Dimensions.font16,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
