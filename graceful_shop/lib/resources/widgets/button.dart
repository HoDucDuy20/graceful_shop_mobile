// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ButtonSignInUp extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  bool isLoading;

  ButtonSignInUp(
      {Key? key,
      this.isLoading = false,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Image.asset(
            'assets/gif/loading_3_2.gif',
            height: Dimensions.h50,
          )
        : MaterialButton(
            onPressed: onPressed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            color: AppColors.mainColor,
            height: Dimensions.h40,
            minWidth: Dimensions.w210,
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: Dimensions.font17,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
          );
  }
}

class ButtonAddCart extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  Color color;
  bool isLoading;

  ButtonAddCart({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.color,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Image.asset(
            'assets/gif/loading_3_2.gif',
            height: Dimensions.h40,
          )
        : MaterialButton(
            onPressed: onPressed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            color: color,
            height: Dimensions.h40,
            minWidth: Dimensions.width / 2.4,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: Dimensions.font15,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          );
  }
}

class ButtonBuyNow extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  Color color;
  bool isLoading;

  ButtonBuyNow({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.color,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading 
        ? Image.asset(
            'assets/gif/loading_3_2.gif',
            height: Dimensions.h50,
          ) 
        : MaterialButton(
            onPressed: onPressed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            color: color,
            height: Dimensions.h50,
            minWidth: Dimensions.width,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: Dimensions.font15,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
          );
  }
}

class ButtonShowMore extends StatelessWidget {
  VoidCallback onPressed;
  ButtonShowMore({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.white3Color,
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(Dimensions.w15),
        padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: AppColors.blueAccentSearchColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SeeMore'.tr,
              style: TextStyle(
                fontSize: Dimensions.font17,
                fontWeight: FontWeight.w500,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(width: Dimensions.w5),
            Icon(
              Icons.expand_more,
              color: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
