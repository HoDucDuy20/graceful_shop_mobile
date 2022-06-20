import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
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
  InvoiceController invoiceController = Get.find<InvoiceController>();
  List<Cart> listCartPay;
  List<int> listCartId = [];
  int totalPrice = 0;

  void updateListCartId(){
    setState(() {});
    listCartId = [];
    for (var i = 0; i < listCartPay.length; i++) {
      totalPrice += listCartPay[i].quantity * listCartPay[i].product.price;
      listCartId.add(listCartPay[i].id);                        
    }
  }

  @override
  void initState() {
    super.initState();
    updateListCartId();
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
                Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.blueAccentColor,
                    ),
                    title: Text('Địa chỉ giao hàng'),
                    subtitle: Text(
                      '558 Bình Quới, P.28, Q.Bình Thạnh',
                    ),
                  ),
                ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
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
                                text: Format.numPrice(totalPrice),
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
                      MaterialButton(
                        onPressed: (){
                          invoiceController.addInvoice(listCartId, null, 0);
                        },
                        color: AppColors.redColor,
                        height: Dimensions.h65,
                        child: Text(
                          'Order'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: Dimensions.font14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
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
}
