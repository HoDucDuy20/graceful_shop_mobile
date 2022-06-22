import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/models/invoice.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/screens/pay/choose_voucher.dart';
import 'package:graceful_shop/services/url.dart';

class InvoiceDetailScreen extends StatefulWidget {
  InvoiceDetailScreen({Key? key, required this.invoice}) : super(key: key);
  Invoice invoice;

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState(invoice: invoice);
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  _InvoiceDetailScreenState({Key? key, required this.invoice});
  InvoiceController invoiceController = Get.find<InvoiceController>();
  Invoice invoice;

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
                  'InvoiceDetails'.tr,
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: Dimensions.h7),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                        color: AppColors.gray3Color,
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.blueAccentColor,
                          ),
                          title: Text(
                            'DeliveryAddress'.tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black2Color,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              text: '${invoice.name} | ${invoice.phone}\n',
                              style: TextStyle(
                                height: 1.7,
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black2Color,
                                letterSpacing: 0.5,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: invoice.address,
                                  style:  TextStyle(
                                  // height: 1.7,
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black2Color,
                                ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: Dimensions.w25,
                          ),
                        ),
                      ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                      shrinkWrap: true,
                      itemCount: invoiceController.invoiceDetailList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.h7,horizontal: Dimensions.w10),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.gray2Color,
                                width: 0.5,
                              ),
                              bottom: BorderSide(
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
                                        invoiceController.invoiceDetailList[index].color.picture,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    invoiceController.invoiceDetailList[index].product.productName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 1.7,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black2Color,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${'Classify'.tr}: ${invoiceController.invoiceDetailList[index].color.colorName} / ${invoiceController.invoiceDetailList[index].size.sizeName}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Format.numPrice(invoiceController.invoiceDetailList[index].product.price),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font13,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blackColor,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            Text(
                                              'x${invoiceController.invoiceDetailList[index].quantity}',
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
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.h7),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h20,horizontal: Dimensions.w10),
                        decoration: BoxDecoration(
                          color: AppColors.gray3Color,
                          border: Border(
                            top: BorderSide(
                              color: AppColors.gray2Color,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: AppColors.gray2Color,
                              width: 0.5,
                            ),
                          ),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${'TheTotalAmount'.tr} (${invoiceController.totalProduct.value} ${'Product'.tr}):',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            Format.numPrice(invoiceController.totalPrice.value),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h20,horizontal: Dimensions.w10),
                        decoration: BoxDecoration(
                          color: AppColors.gray3Color,
                          border: Border(
                            top: BorderSide(
                              color: AppColors.greenColor,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: AppColors.greenColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TransportFee'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            Format.numPrice(invoice.shipPrice??0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greenColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.h7),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.h20,horizontal: Dimensions.w10),
                        decoration: BoxDecoration(
                          color: AppColors.gray3Color,
                          border: Border(
                            top: BorderSide(
                              color: AppColors.gray2Color,
                              width: 0.5,
                            ),
                            bottom: BorderSide(
                              color: AppColors.gray2Color,
                              width: 0.5,
                            ),
                          ),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Voucher'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          if(invoice.voucher != null)
                            Text(
                              '${'Reduce'.tr}: ${Format.numPrice(invoice.voucher?.discountPrice??0)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black2Color,
                                // letterSpacing: 0.5,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimensions.h65,
                  // padding: EdgeInsets.all(Dimensions.w10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.black2Color,
                        width: 0.5,
                      ),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text.rich(
                              TextSpan(
                                text: '${'TotalPayment'.tr}\n',
                                style: TextStyle(
                                  // height: 1.7,
                                  fontSize: Dimensions.font15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: Format.numPrice(invoice.untilPrice),
                                    style:  TextStyle(
                                    // height: 1.7,
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mainColor,
                                  ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),    
                        ],
                      ),
                    ],
                  ), 
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
