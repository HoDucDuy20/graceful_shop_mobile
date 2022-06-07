// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/draw_triangle_shape.dart';
import 'package:graceful_shop/screens/product_detail/product_detail.dart';
import 'package:graceful_shop/services/url.dart';

ProductController productController = Get.find<ProductController>();

Widget GridViewProduct(BuildContext context, List<Product> lstProduct) {
  final orientation = MediaQuery.of(context).orientation;

  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: lstProduct.isEmpty
        ? Center(
            child: Image.asset(
              'assets/gif/loader.gif',
              height: 125.0,
              width: 125.0,
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
                  Get.to(() => ProductDetail(product: lstProduct[index]));
                },
                child: Container(
                  margin: EdgeInsets.all(Dimensions.w10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.h275,
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(Dimensions.w10),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          image: DecorationImage(
                            image: FadeInImage.assetNetwork(
                              placeholder: 'assets/gif/loader.gif',
                              image: formaterImg(
                                  lstProduct[index].pictures[0].pictureValue),
                            ).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.h7),
                            margin: EdgeInsets.only(left: Dimensions.w5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.whiteColor,
                            ),
                            child: Icon(
                              Icons.favorite_outline,
                              size: Dimensions.font20,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: Dimensions.h65,
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.w10),
                        child: Text(
                          lstProduct[index].productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black2Color,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.w10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Format.numPrice(lstProduct[index].price),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font15,
                                color: AppColors.mainColor,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimensions.w5),
                                  child: Icon(
                                    Icons.favorite,
                                    size: Dimensions.font17,
                                    color: AppColors.redColor,
                                  ),
                                ),
                                Text(
                                  lstProduct[index].numLike.toString(),
                                  style: TextStyle(
                                    fontSize: Dimensions.font15,
                                    color: AppColors.black2Color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
              'assets/gif/loader.gif',
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
                        : BoxDecoration(
                            color: AppColors.gray2Color,
                          ),
                    child: Stack(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image(
                            image: FadeInImage.assetNetwork(
                              placeholder: 'assets/gif/loader.gif',
                              image: formaterImg(
                                  productController.colorList[index].picture),
                            ).image,
                            fit: BoxFit.cover,
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(right: Dimensions.w5),
                            child: Text(
                              productController.colorList[index].colorName,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
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
                                    padding:
                                        EdgeInsets.only(left: Dimensions.w20),
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
              'assets/gif/loader.gif',
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
                            overflow: TextOverflow.visible,
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
                                    padding:
                                        EdgeInsets.only(left: Dimensions.w20),
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
