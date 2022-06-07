// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/show_model.dart';
import 'package:graceful_shop/screens/product_detail/list_img.dart';
import 'package:graceful_shop/services/url.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  State<ProductDetail> createState() => _ProductDetailState(product: product);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState({required this.product});

  ProductController productController = Get.find<ProductController>();
  Product product;

  late ScrollController scrollController;
  double scrollControllerOffset = 0.0;

  scrollListenner() {
    setState(() {
      scrollControllerOffset = scrollController.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    productController.getColorSize();
    scrollController = ScrollController();
    scrollController.addListener(scrollListenner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.hCard,
                        child: ListImg(lstImg: product.pictures),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.w10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: TextStyle(
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black2Color,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.h12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            Format.numPrice(product.price),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: Dimensions.font20,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.blueAccentColor,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          product.discountPrice != 0
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: Dimensions.w7),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.w5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppColors.yellowColor,
                                                      width: 1.5,
                                                    ),
                                                    color:
                                                        AppColors.yellow2Color,
                                                  ),
                                                  child: Text(
                                                    Format.percentReduction(
                                                        product.price,
                                                        product.discountPrice),
                                                    style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.redColor,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
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
                                            product.numLike.toString(),
                                            style: TextStyle(
                                              fontSize: Dimensions.font15,
                                              color: AppColors.black2Color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  product.discountPrice != 0
                                      ? Text(
                                          Format.numPrice(
                                              product.discountPrice +
                                                  product.price),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: Dimensions.font15,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            color: AppColors.grayColor,
                                            letterSpacing: 0.5,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showSizeColor(context);
                              },
                              child: productController.colorList.isEmpty
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.all(Dimensions.w5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.grayColor,
                                          width: 0.5,
                                        ),
                                        color: AppColors.whiteColor,
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        minVerticalPadding: 0,
                                        leading: Image(
                                          image: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/gif/loader.gif',
                                            image: formaterImg(productController
                                                .colorList[productController
                                                    .indexColor.value]
                                                .picture),
                                          ).image,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Color'.tr + ', ' + 'Size'.tr,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font15,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.grayColor,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              productController
                                                      .colorList[
                                                          productController
                                                              .indexColor.value]
                                                      .colorName +
                                                  ' / ' +
                                                  productController
                                                      .sizeList[
                                                          productController
                                                              .indexSize.value]
                                                      .sizeName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black2Color,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          size: Dimensions.font40,
                                          color: AppColors.gray2Color,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PreferredSize(
              child: FadeAppBar(scrollOffset: scrollControllerOffset),
              preferredSize: Size(Dimensions.width, Dimensions.h20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.h25,
                horizontal: Dimensions.w20,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: AppColors.whiteColor,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: Dimensions.font30,
                      color: AppColors.black2Color,
                    ),
                  ),
                ),
                trailing:
                    Row(mainAxisSize: MainAxisSize.min, children: lstAction3),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class FadeAppBar extends StatelessWidget {
  FadeAppBar({Key? key, required this.scrollOffset}) : super(key: key);
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: Dimensions.h80,
        color: Colors.white.withOpacity(
          (scrollOffset / 350).clamp(0, 1).toDouble(),
        ),
      ),
    );
  }
}
