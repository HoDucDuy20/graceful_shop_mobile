import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/cart_controller.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/product_type.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

ProductController productController = Get.find<ProductController>();
CartController cartController = Get.find<CartController>();

void showSizeColor(BuildContext context, Product product) async {
  showMaterialModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    builder: (context) => Obx(() {
      return Container(
        height: Dimensions.height / 1.9,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.w10,
                  horizontal: Dimensions.w5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w5,
                      ),
                      child: Text(
                        'Color'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Dimensions.font17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    GridViewColor(context),
                    Divider(
                      color: AppColors.grayColor,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w5,
                      ),
                      child: Text(
                        'Size'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Dimensions.font17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    GridViewSize(context),
                    Divider(color: AppColors.grayColor),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Quantity'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gray2Color,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    productController.reduceTheNumber();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.gray2Color,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.remove_outlined,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.w35,
                                  child: Text(
                                    productController.quantity.value.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.redColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    productController.increasingTheNumber();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.gray2Color,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_outlined,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h65),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grayColor,
                      spreadRadius: 1.5,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: product.quantityStatus == 1
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonAddCart(
                            title: 'AddCart'.tr,
                            onPressed: () {
                              cartController.addCart(
                                product.id,
                                productController.colorList[productController.indexColor.value].id,
                                productController.sizeList[productController.indexSize.value].id,
                                productController.quantity.value,
                              );
                            },
                            color: AppColors.blueAccentColor,
                          ),
                          SizedBox(width: Dimensions.w25),
                          ButtonAddCart(
                            title: 'BuyNow'.tr,
                            onPressed: () {
                              cartController.addCart(
                                product.id,
                                productController.colorList[productController.indexColor.value].id,
                                productController.sizeList[productController.indexSize.value].id,
                                productController.quantity.value,
                              );
                              cartController.showCart();
                            },
                            color: AppColors.redColor,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ProductOutOfStock'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.redColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      )
              ),
            ),
          ],
        ),
      );
    }),
  );
}
