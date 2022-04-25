import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

class Proviso extends StatelessWidget {
  const Proviso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h12),
      child: Text.rich(
        TextSpan(
          text: 'Bằng cách nhấn nút Đăng Ký, bạn đã đồng ý với\n',
          style: TextStyle(
            fontSize: Dimensions.font15,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Điều khoản sử dụng',
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
