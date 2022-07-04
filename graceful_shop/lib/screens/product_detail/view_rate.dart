import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/widgets/grid_view.dart';
import 'package:graceful_shop/resources/widgets/item_grid_view.dart';
import 'package:graceful_shop/screens/rate/edit_rate_product.dart';
import 'package:graceful_shop/services/url.dart';

class ViewRate extends StatelessWidget {
  ViewRate({Key? key, required this.product}) : super(key: key);
  ProductController productController = Get.find<ProductController>();
  RateController rateController = Get.find<RateController>();
  Product product;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white3Color,
          foregroundColor: AppColors.mainColor,
          shadowColor: AppColors.whiteColor,
          elevation: 0.5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                  child: Icon(
                    Icons.chevron_left,
                    size: Dimensions.font30,
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              Text(
                'CustomerRatings'.tr,
                style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            productController.getRateOfProduct(product.id);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h20, horizontal: Dimensions.w15),
                  child: Row(
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
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                  shrinkWrap: true,
                  itemCount: productController.rateList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h7, horizontal: Dimensions.w15),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.gray2Color,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.blueAccentColor,
                              backgroundImage: FadeInImage.assetNetwork(
                                placeholder: 'assets/gif/loading_2.gif',
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
