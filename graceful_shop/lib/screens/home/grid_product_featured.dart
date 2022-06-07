// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';

class GridProductFeatured extends StatelessWidget {
  GridProductFeatured({Key? key}) : super(key: key);
  ProductController productController = Get.find<ProductController>();

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
            productController.productList.value,
          ),
          (productController.checkFull.value == true ||
                  productController.productList.value.length == 0)
              ? SizedBox(
                  height: Dimensions.h40,
                )
              : productController.loading.value
                  ? CircularProgressIndicator.adaptive()
                  : InkWell(
                      highlightColor: AppColors.white3Color,
                      onTap: () {
                        productController.loading.value = true;
                        productController.getPopularProducts();
                      },
                      child: Container(
                        margin: EdgeInsets.all(Dimensions.w15),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
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
                            SizedBox(
                              width: Dimensions.w5,
                            ),
                            Icon(
                              Icons.expand_more,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      );
    });
  }
}
