import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/login_with_google.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:provider/provider.dart';

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
          'OrLogin'.tr,
          style: TextStyle(
            fontSize: Dimensions.font17,
            fontWeight: FontWeight.w600,
            color: AppColors.grayColor,
          ),
        ),
        InkWell(
          onTap: () {
            final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
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
              'assets/svg/icons/icon_google.svg',
            ),
          ),
        ),
      ],
    );
  }
}
