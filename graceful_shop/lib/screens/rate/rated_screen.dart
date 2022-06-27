import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/models/rate_product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/screens/rate/edit_rate_product.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:http/http.dart';

class RatedScreen extends StatefulWidget {
  RatedScreen({Key? key, required this.listProductRate}) : super(key: key);
  List<RatedProduct> listProductRate;

  @override
  State<RatedScreen> createState() => _RateScreenState(listProductRate: listProductRate);
}

class _RateScreenState extends State<RatedScreen> {
  _RateScreenState({Key? key, required this.listProductRate});
  RateController rateController = Get.find<RateController>();
  List<RatedProduct> listProductRate;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          body: rateController.isLoading.value
          ? SizedBox(
            height: Dimensions.h20,
            width: Dimensions.w20,
            child: Image.asset(
                'assets/gif/loading_5.gif',
              ),
          )
          : listProductRate.isEmpty
            ? Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: Dimensions.h200,
                  width: Dimensions.w210,
                  child: const Image(
                    image: AssetImage('assets/images/rate.png'),
                  ),
                ),
              )
            : Container(
              color: AppColors.gray3Color,
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                shrinkWrap: true,
                itemCount: listProductRate.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      rateController.ratedDetail(listProductRate[index].rate.id);
                      Get.to(() => EditRateProduct(product: listProductRate[index].product));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.h10),
                      color: AppColors.whiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: SizedBox(
                              child: FadeInImage.assetNetwork(
                                width: Dimensions.w65,
                                height: Dimensions.w100,
                                placeholder: 'assets/gif/loading_2.gif',
                                image: formaterImg(
                                  listProductRate[index].product.pictures[0].pictureValue,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              listProductRate[index].product.productName,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                                letterSpacing: 0.7,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Format.numPrice(listProductRate[index].product.price),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black2Color,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ],
                            ),  
                            trailing: Icon(
                              Icons.edit_outlined,
                              size: Dimensions.font20,
                              color: AppColors.mainColor,
                            ),                      
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: Dimensions.h5, horizontal: Dimensions.w10),
                            child: Row(
                              children: [
                                RatingBarIndicator(
                                  rating: listProductRate[index].rate.numRate.toDouble(),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                  ),
                                  itemCount: 5,
                                  itemSize: Dimensions.w15,
                                  direction: Axis.horizontal,
                                ),
                                SizedBox(width: Dimensions.w10,),
                                Text(
                                  Format.dateTime(listProductRate[index].rate.createdAt),
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black2Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: Dimensions.h10),
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
                            child: Text(
                              listProductRate[index].rate.description,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black2Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
        );
      }
    );
  }
}