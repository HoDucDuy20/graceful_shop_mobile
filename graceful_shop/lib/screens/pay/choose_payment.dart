import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';

class ChoosePaymentScreen extends StatefulWidget {
  const ChoosePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePaymentScreen> createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  InvoiceController invoiceController = Get.find<InvoiceController>();
  int paymentIndex = 0;
  @override 
  void initState() {
    super.initState();
    paymentIndex = invoiceController.paymentIndex.value;
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
              'ChoosePayment'.tr,
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
            child: Container(
              color: AppColors.gray3Color,
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: Dimensions.h10),
                    shrinkWrap: true,
                    itemCount: invoiceController.payments.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: Dimensions.h10),
                        color: AppColors.whiteColor,
                        child: ListTile(
                          onTap: (){
                            setState(() {});
                            if(paymentIndex != index){
                              paymentIndex = index;
                            }
                          },
                          leading: SizedBox(  
                            width: Dimensions.w65,
                            height: Dimensions.w100,
                            child: Image(
                              image: AssetImage(invoiceController.payments[index].icon),
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            invoiceController.payments[index].title.tr,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              letterSpacing: 0.7,
                            ),
                          ),
                          trailing: InkWell(
                            onTap: (){},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                paymentIndex == index
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
                  invoiceController.paymentIndex.value = paymentIndex;
                  Get.back();       
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
      ),
    );
  }
}
