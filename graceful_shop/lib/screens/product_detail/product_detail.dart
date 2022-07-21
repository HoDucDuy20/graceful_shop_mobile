// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/actions.dart';
import 'package:graceful_shop/resources/widgets/button.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/resources/widgets/show_model.dart';
import 'package:graceful_shop/resources/widgets/title.dart';
import 'package:graceful_shop/screens/product_detail/list_img.dart';
import 'package:graceful_shop/screens/product_detail/view_rate.dart';
import 'package:graceful_shop/screens/rate/edit_rate_product.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  State<ProductDetail> createState() => _ProductDetailState(product: product);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState({required this.product});

  ProductController productController = Get.find<ProductController>();
  RateController rateController = Get.find<RateController>();
  UserController userController = Get.find<UserController>();
  Product product;

  late ScrollController scrollController;
  double scrollControllerOffset = 0.0;

  void _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    // print(_url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  scrollListenner() {
    setState(() {
      scrollControllerOffset = scrollController.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    productController.getColorSize(product.id);
    productController.getRateOfProduct(product.id);
    scrollController = ScrollController();
    scrollController.addListener(scrollListenner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                productController.getColorSize(product.id);
                productController.getRateOfProduct(product.id);
              },
              child: SingleChildScrollView(
                controller: scrollController,
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
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black2Color,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: Dimensions.h12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                        // if (product.discountPrice != 0)
                                        //   Container(
                                        //     margin: EdgeInsets.only(left: Dimensions.w7),
                                        //     padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                                        //     decoration: BoxDecoration(
                                        //       border: Border.all(
                                        //         color: AppColors.yellowColor,
                                        //         width: 1.5,
                                        //       ),
                                        //       color: AppColors.yellow2Color,
                                        //     ),
                                        //     child: Text(
                                        //       Format.percentReduction(product.price,product.discountPrice),
                                        //       style: TextStyle(
                                        //         fontSize: Dimensions.font15,
                                        //         fontWeight: FontWeight.w500,
                                        //         color: AppColors.redColor,
                                        //         letterSpacing: 0.5,
                                        //       ),
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${productController.numOrder} Lượt mua ',
                                          style: TextStyle(
                                            fontSize: Dimensions.font14,
                                            color: AppColors.black2Color,
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Padding(
                                          padding: EdgeInsets.only(right: Dimensions.w5),
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
                                // if (product.discountPrice != 0)
                                //   Text(
                                //     Format.numPrice(product.discountPrice + product.price),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(
                                //       decoration: TextDecoration.lineThrough,
                                //       fontSize: Dimensions.font15,
                                //       fontWeight: FontWeight.w400,
                                //       fontStyle: FontStyle.italic,
                                //       color: AppColors.grayColor,
                                //       letterSpacing: 0.5,
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                          if (productController.colorList.isNotEmpty)
                            InkWell(
                              onTap: () {
                                showSizeColor(context, product);
                              },
                              child: Container(
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
                                      placeholder: 'assets/gif/loading_2.gif',
                                      image: formaterImg(productController.colorList[productController.indexColor.value].picture),
                                    ).image,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${'Color'.tr}, ${'Size'.tr}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: Dimensions.font15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.grayColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${productController.colorList[productController.indexColor.value].colorName} / ${productController.sizeList[productController .indexSize.value].sizeName}',
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
                          titleProductDetail('ProductDescription'.tr),
                          Html(
                            data: product.description,
                            onLinkTap: (String? url,
                                RenderContext context,
                                Map<String, String> attributes,
                                dom.Element? element) {
                              _launchUrl(url!);
                            },
                          ),
                          titleProductDetail('CustomerRatings'.tr),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: product.numRate,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: AppColors.yellowColor,
                                ),
                                itemCount: 5,
                                itemSize: Dimensions.w30,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(width: 10),
                              Text.rich(
                                TextSpan(
                                  text: '${Format.numRate(product.numRate)}/5.0  ',
                                  style: TextStyle(
                                    wordSpacing: 1.5,
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red3Color,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '(${productController.rateList.length} ${'Rating'.tr})',
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: Dimensions.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.grayColor,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          if (productController.rateList.isNotEmpty)
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                              shrinkWrap: true,
                              itemCount: productController.rateList.length > 3 ? 3 : productController.rateList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.gray2Color,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: AppColors.blueAccentColor,
                                          backgroundImage: FadeInImage.assetNetwork(
                                            placeholder:'assets/gif/loading_2.gif',
                                            image: formaterImg(productController.rateList[index].user!.avatar),
                                            fit: BoxFit.cover,
                                          ).image,
                                        ),
                                        title: Text(
                                          productController.rateList[index].user!.fullName,
                                          style: TextStyle(
                                            height: 1.5,
                                            fontSize: Dimensions.font14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.grayColor,
                                          ),
                                        ),
                                        subtitle: RatingBarIndicator(
                                          rating: productController.rateList[index].numRate.toDouble(),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: AppColors.yellowColor,
                                          ),
                                          itemCount: 5,
                                          itemSize: Dimensions.w15,
                                          direction: Axis.horizontal,
                                        ),
                                        trailing: productController.rateList[index].user!.id == userController.user.value.id 
                                          ? Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    rateController.ratedDetail(productController.rateList[index].id);
                                                    Get.to(() => EditRateProduct(product: product));
                                                  },
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: Dimensions.font17,
                                                    color: AppColors.mainColor,
                                                  ),  
                                                ),
                                                SizedBox(
                                                  height: Dimensions.h5,
                                                ),
                                                Text(
                                                  Format.dateTime(productController.rateList[index].createdAt),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              Format.dateTime(productController.rateList[index].createdAt),
                                            )
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: Dimensions.h7),
                                        child: Text(
                                          productController.rateList[index].description,
                                          style: TextStyle(
                                            height: 1.5,
                                            fontSize: Dimensions.font15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black2Color,
                                          ),
                                        ),
                                      ),
                                      if (productController.rateList[index].picturesRate.isNotEmpty)
                                        GridViewImageRate(context, productController.rateList[index].picturesRate)
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (productController.rateList.length > 3)
                            InkWell(
                              onTap: () {
                                Get.to(ViewRate(product: product), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeft);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: AppColors.gray2Color,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4, bottom: 5),
                                      child: Text(
                                        'SeeMore'.tr,
                                        style: TextStyle(
                                          fontSize: Dimensions.font14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(
                                        Icons.expand_more,
                                        size: Dimensions.font15,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          SizedBox(height: Dimensions.h80),
                        ],
                      ),
                          
                    ),
                  ],              
                ),
              ),
            ),
            PreferredSize(
              preferredSize: Size(Dimensions.width, Dimensions.h20),
              child: FadeAppBar(scrollOffset: scrollControllerOffset),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h25, horizontal: Dimensions.w20),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                      color: AppColors.whiteColor,
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: Dimensions.font30,
                      color: AppColors.black2Color,
                    ),
                  ),
                ),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: lstAction3),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: Dimensions.h65,
                padding: EdgeInsets.all(Dimensions.w10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.black2Color,
                      width: 0.5,
                    ),
                  ),
                  color: AppColors.whiteColor,
                ),
                child: ButtonBuyNow(
                  title: 'BuyNow'.tr,
                  onPressed: () {
                    showSizeColor(context, product);
                  },
                  color: AppColors.redColor,
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class FadeAppBar extends StatelessWidget {
  const FadeAppBar({Key? key, required this.scrollOffset}) : super(key: key);
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
