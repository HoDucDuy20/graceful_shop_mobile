import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/voucher_controller.dart';
import 'package:graceful_shop/models/voucher.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';

class ChooseVoucherScreen extends StatefulWidget {
  const ChooseVoucherScreen({Key? key}) : super(key: key);

  @override
  State<ChooseVoucherScreen> createState() => _ChooseVoucherScreenState();
}

class _ChooseVoucherScreenState extends State<ChooseVoucherScreen> {
  VoucherController voucherController = Get.find<VoucherController>();
  int voucherId = -1;
  Voucher voucherPay = Voucher(id: -1, voucherCode: '', description: '', minTotalPrice: 0, discountPrice: 0, startDate: '', endDate: '');

  void getVoucherId(){
    voucherId = voucherController.voucherPay.value.id;
  }

  @override
  void initState() {
    super.initState();
    voucherController.getVoucher();
    getVoucherId();
  }

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
              'ChooseVoucher'.tr,
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
                              onTap: (){
                                setState(() {});
                                if(voucherId == voucherController.voucherList[index].id){
                                  voucherId = -1;
                                  voucherPay = Voucher(id: -1, voucherCode: '', description: '', minTotalPrice: 0, discountPrice: 0, startDate: '', endDate: '');
                                }else{
                                  voucherId = voucherController.voucherList[index].id;
                                  voucherPay = voucherController.voucherList[index];
                                }
                              },
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
                              trailing: InkWell(
                                onTap: (){},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    voucherId == voucherController.voucherList[index].id
                                     ? Icons.check_circle
                                     : Icons.circle_outlined,
                                    size: Dimensions.font20,  
                                    color: AppColors.greenColor,                                  
                                  ),
                                ),
                              ),                       
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimensions.h40,
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
                  child: MaterialButton(
                    onPressed: (){
                      voucherController.addVoucherPay(voucherPay);                    
                    },
                    color: AppColors.redColor,
                    height: Dimensions.h50,
                    minWidth: Dimensions.width,
                    child: Text(
                      'Agree'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: Dimensions.font15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
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
