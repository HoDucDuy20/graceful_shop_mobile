import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hoặc đăng nhập bằng',
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.w600,
            color: AppColors.grayColor,
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(Dimensions.h12),
            padding: EdgeInsets.all(Dimensions.w7),
            height: Dimensions.h40,
            width: Dimensions.w40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/svg/icon_google.svg',
            ),
          ),
        ),
      ],
    );
  }
}
