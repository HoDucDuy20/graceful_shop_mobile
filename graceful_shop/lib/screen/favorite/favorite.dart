import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/object/product_object.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/screen/favorite/no_product.dart';
import 'package:graceful_shop/screen/favorite/not_logged_in.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  String Token = '';
  List<ProductObject> lstProduct = [
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
    ProductObject('Áo cổ rộng gợi cảm', 'assets/images/img_2.jpg', 250000, 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.w25,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white3Color,
        foregroundColor: AppColors.mainColor,
        shadowColor: AppColors.whiteColor,
        elevation: 0.5,
        title: Text(
          'Favorite'.tr,
          style: TextStyle(
            fontSize: Dimensions.font25,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: lstAction1,
      ),
      body: SingleChildScrollView(
        child: Token.isEmpty
            ? NotLoggedIn()
            : Column(
                children: [
                  if (lstProduct.isEmpty) NoProduct() else Container(),
                ],
              ),
      ),
    );
  }
}
