import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/services/url.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key? key, required this.listCartPay}) : super(key: key);
  List<Cart> listCartPay;

  @override
  State<PayScreen> createState() => _PayScreenState(listCartPay: listCartPay);
}

class _PayScreenState extends State<PayScreen> {
  _PayScreenState({Key? key, required this.listCartPay});
  List<Cart> listCartPay;

  @override
  Widget build(BuildContext context) {
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
              'Pay'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                  shrinkWrap: true,
                  itemCount: listCartPay.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h7,horizontal: Dimensions.w10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.gray2Color,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: SizedBox(
                                child: FadeInImage.assetNetwork(
                                  width: Dimensions.w65,
                                  height: Dimensions.w100,
                                  placeholder: 'assets/gif/loading_2.gif',
                                  image: formaterImg(
                                    listCartPay[index].color.picture,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                listCartPay[index].product.productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1.7,
                                  fontSize: Dimensions.font15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${'Classify'.tr}: ${listCartPay[index].color.colorName} / ${listCartPay[index].size.sizeName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: Dimensions.font12,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.grayColor,
                                        letterSpacing: 0.5,
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Format.numPrice(listCartPay[index].product.price),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Dimensions.font13,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.grayColor,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Text(
                                          'x${listCartPay[index].quantity}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: Dimensions.font12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.grayColor,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
