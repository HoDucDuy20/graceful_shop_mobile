import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/models/invoice.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({Key? key, required this.listInvoice}) : super(key: key);
  List<Invoice> listInvoice;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState(listInvoice: listInvoice);
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  _InvoiceScreenState({Key? key, required this.listInvoice, });
  InvoiceController invoiceController = Get.find<InvoiceController>();
  List<Invoice> listInvoice;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          body: invoiceController.isLoading.value
          ? Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                // height: Dimensions.h20,
                width: Dimensions.w210,
                child: Image.asset(
                    'assets/gif/loading_5.gif',
                  ),
              ),
            )
          : listInvoice.isEmpty
            ? Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: Dimensions.h200,
                  width: Dimensions.w210,
                  child: const Image(
                    image: AssetImage('assets/images/invoice.png'),
                  ),
                ),
              )
            : Container(
              color: AppColors.gray3Color,
              child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                shrinkWrap: true,
                itemCount: listInvoice.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      invoiceController.showInvoiceDetail(listInvoice[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.h10),
                      color: AppColors.whiteColor,
                      child: ListTile(
                        title: Text(
                          '${'InvoiceCode'.tr}: ${listInvoice[index].invoiceCode}',
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
                              '${'DateFounded'.tr}: ${Format.dateTime(listInvoice[index].createdAt.toString())}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black2Color,
                                letterSpacing: 0.7,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if((listInvoice[index].typePay != '' && listInvoice[index].typePay != 'tm' && listInvoice[index].status != 0) || listInvoice[index].status == 4)
                                    Text.rich(
                                      TextSpan(
                                        text: 'Paid'.tr,
                                        style: TextStyle(
                                          height: 1.7,
                                          fontSize: Dimensions.font14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.greenColor,
                                        ),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  const SizedBox(width: 1,),
                                  Text.rich(
                                    TextSpan(
                                      text: '${'TotalPayment'.tr}:  ',
                                      style: TextStyle(
                                        height: 1.7,
                                        fontSize: Dimensions.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black2Color,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: Format.numPrice(listInvoice[index].untilPrice),
                                          style:  TextStyle(
                                            // height: 1.7,
                                            fontSize: Dimensions.font14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.orangeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                          ],
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