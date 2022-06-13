// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/product_detail/product_detail.dart';
import 'package:graceful_shop/services/url.dart';

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
    final orientation = MediaQuery.of(context).orientation;

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

          // GridViewProduct(
          //   context,
          //   productController.productList.value,
          //   false,
          //   false,
          // ),

          Obx(() {
            return Container(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: productController.productList.isEmpty
                    ? Center(
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
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3,
                          mainAxisExtent: Dimensions.hCard,
                        ),
                        itemCount: productController.productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            highlightColor: AppColors.whiteColor,
                            onTap: () {
                              Get.to(() => ProductDetail(
                                  product:
                                      productController.productList[index]));
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
                                          placeholder:
                                              'assets/gif/loading_2.gif',
                                          image: formaterImg(productController
                                              .productList[index]
                                              .pictures[0]
                                              .pictureValue),
                                        ).image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (userController.token.value == '') {
                                          showLogIn();
                                          return;
                                        }
                                        favoriteController.like(index);
                                        setState(() {
                                          productController
                                                  .productList[index].isLike =
                                              !productController
                                                  .productList[index].isLike;
                                          if (productController
                                              .productList[index].isLike) {
                                            productController
                                                .productList[index].numLike++;
                                          } else {
                                            productController
                                                .productList[index].numLike--;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(Dimensions.h7),
                                        margin: EdgeInsets.only(
                                            left: Dimensions.w5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColors.whiteColor,
                                        ),
                                        child: productController
                                                .productList[index].isLike
                                            ? Icon(
                                                Icons.favorite,
                                                size: Dimensions.font20,
                                                color: AppColors.redColor,
                                              )
                                            : Icon(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w10),
                                    child: Text(
                                      productController
                                          .productList[index].productName,
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Format.numPrice(productController
                                              .productList[index].price),
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
                                              padding: EdgeInsets.only(
                                                  right: Dimensions.w5),
                                              child: Icon(
                                                Icons.favorite,
                                                size: Dimensions.font17,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                            Text(
                                              productController
                                                  .productList[index].numLike
                                                  .toString(),
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
              ),
            );
          }),
          (productController.checkFull.value == true ||
                  productController.productList.value.length == 0)
              ? SizedBox(
                  height: Dimensions.h40,
                )
              : productController.loading.value
                  ? Center(
                      child: Image.asset(
                        'assets/gif/loading_2_2.gif',
                        height: Dimensions.h50,
                      ),
                    )
                  : ButtonShowMore(
                      onPressed: () {
                        productController.loading.value = true;
                        productController.getPopularProducts();
                      },
                    ),
        ],
      );
    });
  }
}
