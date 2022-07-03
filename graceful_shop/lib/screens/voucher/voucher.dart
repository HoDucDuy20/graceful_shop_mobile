import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/voucher_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({Key? key}) : super(key: key);

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  VoucherController voucherController = Get.find<VoucherController>();

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
              'Voucher'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: AppColors.gray3Color,
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: Dimensions.h10),
                        shrinkWrap: true,
                        itemCount: voucherController.voucherList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: Dimensions.h10),
                            color: AppColors.whiteColor,
                            child: ListTile(
                              title: Text(
                                voucherController.voucherList[index].description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Dimensions.font17,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                  letterSpacing: 0.7,
                                ),
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  text: 'HSD: ${Format.date(voucherController.voucherList[index].endDate.toString())}\n',
                                  style: TextStyle(
                                    height: 1.7,
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.orangeColor,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${'OrdersFrom'.tr}: ${Format.numPrice(voucherController.voucherList[index].minTotalPrice)}. ${'Reduce'.tr}: ${Format.numPrice(voucherController.voucherList[index].discountPrice)}',
                                      style:  TextStyle(
                                      // height: 1.7,
                                      fontSize: Dimensions.font14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black2Color,
                                    ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              // trailing: Column(
                              //   children: [
                              //     Icon(
                              //         Icons.location_on_outlined,
                              //         color: AppColors.mainColor,
                              //     ),
                              //     if(VoucherController.VoucherList[index].isDefault)
                              //       Padding(
                              //         padding: const EdgeInsets.only(top: 5.0),
                              //         child: Icon(
                              //             Icons.check,
                              //             color: AppColors.mainColor,
                              //         ),
                              //       ),                                
                              //   ],
                              // ),                            
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
