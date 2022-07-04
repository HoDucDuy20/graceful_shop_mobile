// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/favorite_controller.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/picture.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/widgets/draw_triangle_shape.dart';
import 'package:graceful_shop/resources/widgets/img_view.dart';
import 'package:graceful_shop/resources/widgets/item_grid_view.dart';
import 'package:graceful_shop/screens/product_detail/product_detail.dart';
import 'package:graceful_shop/services/url.dart';

ProductController productController = Get.find<ProductController>();
FavoriteController favoriteController = Get.find<FavoriteController>();

Widget GridViewProduct(BuildContext context, List<Product> lstProduct, int total, bool isSearch, bool isFavorite) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: lstProduct.isEmpty
        ? total == 0
            ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimensions.w40),
                child: Text(
                  'NoProducts'.tr,
                  style: TextStyle(
                    fontSize: Dimensions.font17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayColor,
                    letterSpacing: 0.5,
                  ),
                ),
              )
            : Center(
                child: Image.asset(
                  'assets/gif/loading_5.gif',
                  height: Dimensions.w250,
                  width: Dimensions.w250,
                ),
              )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              mainAxisExtent: Dimensions.hCard,
            ),
            itemCount: lstProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                highlightColor: AppColors.whiteColor,
                onTap: () {
                  Get.to(ProductDetail(product: lstProduct[index]), duration: const Duration(milliseconds: 400), transition: Transition.zoom);
                },
                child: Container(
                  margin: EdgeInsets.all(Dimensions.w10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray2Color,
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(1.5, 2.5),
                      ),
                    ],
                  ),
                  child: ItemGridView(
                    product: lstProduct[index],
                    index: index,
                    isSearch: isSearch,
                    isFavorite: isFavorite,
                  ),
                ),
              );
            },
          ),
  );
}

// Image.network(
//   formaterImg(lstProduct[index].pictures[0].pictureValue),
//   loadingBuilder: (BuildContext context, Widget child,
//       ImageChunkEvent? loadingProgress) {
//     if (loadingProgress == null) return child;
//     return Center(
//       child: CircularProgressIndicator(
//         value: loadingProgress.expectedTotalBytes != null
//             ? loadingProgress.cumulativeBytesLoaded /
//                 loadingProgress.expectedTotalBytes!
//             : null,
//       ),
//     );
//   },
// ).image,

Widget GridViewColor(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: productController.colorList.isEmpty
        ? Center(
            child: Image.asset(
              'assets/gif/loading_2.gif',
              height: 50.0,
              width: 50.0,
            ),
          )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              mainAxisExtent: Dimensions.h65,
            ),
            itemCount: productController.colorList.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return InkWell(
                  highlightColor: AppColors.whiteColor,
                  onTap: () {
                    if (productController.indexColor.value != index) {
                      productController.quantity.value = 1;
                    }
                    productController.indexColor.value = index;
                  },
                  child: Container(
                    margin: EdgeInsets.all(Dimensions.w5),
                    decoration: productController.indexColor.value == index
                        ? BoxDecoration(
                            color: AppColors.white2Color,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blueAccentSearchColor,
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(2.5, 2.5),
                              ),
                            ],
                          )
                        : BoxDecoration(color: AppColors.gray2Color),
                    child: Stack(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image(
                            image: FadeInImage.assetNetwork(
                              placeholder: 'assets/gif/loading_2.gif',
                              image: formaterImg(productController.colorList[index].picture),
                            ).image,
                            fit: BoxFit.cover,
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(right: Dimensions.w5),
                            child: Text(
                              productController.colorList[index].colorName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        productController.indexColor.value == index
                            ? Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                  size: Size(Dimensions.w30, Dimensions.w30),
                                  painter: DrawTriangleShape(),
                                  child: Container(
                                    padding: EdgeInsets.only(left: Dimensions.w20),
                                    child: Icon(
                                      Icons.done,
                                      size: Dimensions.w20,
                                      color: AppColors.black2Color,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
  );
}

Widget GridViewSize(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: productController.sizeList.isEmpty
        ? Center(
            child: Image.asset(
              'assets/gif/loading_2.gif',
              height: 50.0,
              width: 50.0,
            ),
          )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 4 : 6,
              mainAxisExtent: Dimensions.h40,
            ),
            itemCount: productController.sizeList.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                return InkWell(
                  highlightColor: AppColors.whiteColor,
                  onTap: () {
                    if (productController.indexSize.value != index) {
                      productController.quantity.value = 1;
                    }
                    productController.indexSize.value = index;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(Dimensions.w5),
                    decoration: productController.indexSize.value == index
                        ? BoxDecoration(
                            color: AppColors.white2Color,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blueAccentSearchColor,
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(2.5, 2.5),
                              ),
                            ],
                          )
                        : BoxDecoration(
                            color: AppColors.gray2Color,
                          ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            productController.sizeList[index].sizeName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        productController.indexSize.value == index
                            ? Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                  size: Size(Dimensions.w30, Dimensions.w30),
                                  painter: DrawTriangleShape(),
                                  child: Container(
                                    padding: EdgeInsets.only(left: Dimensions.w20),
                                    child: Icon(
                                      Icons.done,
                                      size: Dimensions.w15,
                                      color: AppColors.black2Color,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
  );
}

Widget GridViewImageRate(BuildContext context, List<PicturesRate> lstPictureRate) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
        mainAxisExtent: Dimensions.h180,
      ),
      itemCount: lstPictureRate.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          highlightColor: AppColors.whiteColor,
          onTap: () {
            Get.to(() => ImgRateView(lstImgRate: lstPictureRate, i: index));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.w5),
            padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray2Color,
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(1.5, 2.5),
                ),
              ],
            ),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/gif/loading_2.gif',
              image: formaterImg(lstPictureRate[index].pictureValue),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}

Widget GridViewProduct2(BuildContext context, List<Product> lstProduct, int total) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: lstProduct.isEmpty
        ? total == 0
            ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimensions.w40),
                child: Text(
                  'NoProducts'.tr,
                  style: TextStyle(
                    fontSize: Dimensions.font17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayColor,
                    letterSpacing: 0.5,
                  ),
                ),
              )
            : Center(
                child: Image.asset(
                  'assets/gif/loading_5.gif',
                  height: Dimensions.w250,
                  width: Dimensions.w250,
                ),
              )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              mainAxisExtent: Dimensions.hCard2,
            ),
            itemCount: lstProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                highlightColor: AppColors.whiteColor,
                onTap: () {
                   Get.to(ProductDetail(product: lstProduct[index]), duration: const Duration(milliseconds: 400), transition: Transition.zoom);
                },
                child: Container(
                  margin: EdgeInsets.all(Dimensions.w10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray2Color,
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(1.5, 2.5),
                      ),
                    ],
                  ),
                  child: ItemGridView2(
                    product: lstProduct[index],
                    index: index,
                  ),
                ),
              );
            },
          ),
  );
}