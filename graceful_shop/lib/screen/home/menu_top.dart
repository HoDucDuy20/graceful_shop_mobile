import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class MenuTop extends StatelessWidget {
  const MenuTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h7),
      leading: SvgPicture.asset(
        'assets/svg/logo.svg',
        height: Dimensions.h40,
      ),
      title: SizedBox(
        height: Dimensions.h30,
        child: TextField(
          autofocus: false,
          readOnly: true,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AdvertiseDetail()));
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            filled: true,
            fillColor: AppColors.blueAccentSearchColor,
            prefixIcon: const Icon(Icons.search),
            label: Text(
              'Search'.tr,
              style: TextStyle(fontSize: Dimensions.font16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(Dimensions.h7),
              margin: EdgeInsets.only(right: Dimensions.w5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white2Color,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.mainColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(Dimensions.h7),
              margin: EdgeInsets.only(left: Dimensions.w5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white2Color,
              ),
              child: Icon(
                Icons.message_outlined,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
