import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/screens/rate/rate_product.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:http/http.dart';

class RateScreen extends StatefulWidget {
  RateScreen({Key? key, required this.listProductRate}) : super(key: key);
  List<Product> listProductRate;
  @override
  State<RateScreen> createState() => _RateScreenState(listProductRate: listProductRate);
}

class _RateScreenState extends State<RateScreen> {
  _RateScreenState({Key? key, required this.listProductRate});
  RateController rateController = Get.find<RateController>();
  List<Product> listProductRate;

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
                      Get.to(() => RateProduct(product: listProductRate[index]));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.h10),
                      color: AppColors.whiteColor,
                      child: ListTile(
                        leading: SizedBox(
                          child: FadeInImage.assetNetwork(
                            width: Dimensions.w65,
                            height: Dimensions.w100,
                            placeholder: 'assets/gif/loading_2.gif',
                            image: formaterImg(
                              listProductRate[index].pictures[0].pictureValue,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          listProductRate[index].productName,
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
                              Format.numPrice(listProductRate[index].price),
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
                          Icons.rate_review,
                          size: Dimensions.font20,
                          color: AppColors.mainColor,
                        ),                      
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