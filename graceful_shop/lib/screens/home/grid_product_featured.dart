// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';

class GridProductFeatured extends StatefulWidget {
  const GridProductFeatured({Key? key}) : super(key: key);
  @override
  State<GridProductFeatured> createState() => _GridProductFeaturedState();
}

class _GridProductFeaturedState extends State<GridProductFeatured> {
  ProductController productController = Get.find<ProductController>();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          // InkWell(
          //   highlightColor: AppColors.blueAccentSearchColor,
          //   onTap: () {},
          //   child: ListTile(
          //     // tileColor: Colors.blueGrey,
          //     title: Text(
          //       'Hàng mới',
          //       style: TextStyle(
          //           fontSize: Dimensions.font20, fontWeight: FontWeight.w600),
          //     ),
          //     trailing: Icon(
          //       Icons.chevron_right,
          //       size: Dimensions.font40,
          //     ),
          //   ),
          // ),
          GridViewProduct(
            context,
            productController.productList,
            productController.total.value,
            false,
            false,
          ),
          // (productController.checkFull.value == true || productController.productList.isEmpty)
          //     ? SizedBox(
          //         height: Dimensions.h40,
          //       )
          //     : productController.loading.value
          //         ? Center(
          //             child: Image.asset(
          //               'assets/gif/loading_2_2.gif',
          //               height: Dimensions.h50,
          //             ),
          //           )
          //         : ButtonShowMore(
          //             onPressed: () {
          //               productController.loading.value = true;
          //               productController.getPopularProducts();
          //             },
          //           ),
        ],
      );
    });
  }
}
