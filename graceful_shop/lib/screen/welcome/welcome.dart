import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/utils/dimensions.dart';

import '../login/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), push);
  }

  void push() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.h250,
              width: Dimensions.w250,
              child: SvgPicture.asset('assets/svg/logo.svg'),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimensions.h20),
              child: Text(
                'GRACEFUL SHOP',
                style: TextStyle(
                  fontSize: Dimensions.font40,
                  color: AppColors.grayColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
