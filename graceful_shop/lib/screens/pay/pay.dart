import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/address_controller.dart';
import 'package:graceful_shop/controllers/invoice_controller.dart';
import 'package:graceful_shop/controllers/repo/payment.dart';
import 'package:graceful_shop/controllers/voucher_controller.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/models/voucher.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/resources/utils/util.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/pay/choose_address.dart';
import 'package:graceful_shop/screens/pay/choose_payment.dart';
import 'package:graceful_shop/screens/pay/choose_voucher.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:graceful_shop/zalo_pay/flutter_zalopay_sdk.dart';

class PayScreen extends StatefulWidget {
  PayScreen({Key? key, required this.listCartPay}) : super(key: key);
  List<Cart> listCartPay;

  @override
  State<PayScreen> createState() => _PayScreenState(listCartPay: listCartPay);
}

class _PayScreenState extends State<PayScreen> {
  _PayScreenState({Key? key, required this.listCartPay});
  InvoiceController invoiceController = Get.find<InvoiceController>();
  AddressController addressController = Get.find<AddressController>();
  VoucherController voucherController = Get.find<VoucherController>();

  List<Cart> listCartPay;
  List<int> listCartId = [];
  int totalPrice = 0;
  int quantity = 0;
  int untilPrice = 0;
  int transportFee = 35000;

  void updateListCartId(){
    setState(() {});
    listCartId = [];
    for (var i = 0; i < listCartPay.length; i++) {
      totalPrice += listCartPay[i].quantity * listCartPay[i].product.price;
      listCartId.add(listCartPay[i].id);                        
    }
  }

  void quantityOfProduct(){
    for (var value in listCartPay) {
      quantity += value.quantity;
    }
  }

  void totalUntilPrice(){
    untilPrice += totalPrice + transportFee;
  }

  @override
  void initState() {
    super.initState();
    addressController.getAddress();
    updateListCartId();
    quantityOfProduct();
    totalUntilPrice();
    voucherController.voucherPay.value = Voucher(id: -1, voucherCode: '', description: '', minTotalPrice: 0, discountPrice: 0, startDate: '', endDate: '');
    invoiceController.paymentIndex.value = 0;
  }

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
                  if(addressController.addressPay.value.id == -1)
                    InkWell(
                      onTap: (){
                        Get.to( const ChooseAddressScreen(), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeftWithFade);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: Dimensions.h7),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                        color: AppColors.gray3Color,
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.blueAccentColor,
                          ),
                          title: Text(
                            'PleaseSelectAddress'.tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grayColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: Dimensions.w25,
                          ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: (){
                        Get.to( const ChooseAddressScreen(), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeftWithFade);
                      },
                      child: Container(
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
                              text: '${addressController.addressPay.value.name} | ${addressController.addressPay.value.phoneNumber}\n',
                              style: TextStyle(
                                height: 1.7,
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black2Color,
                                letterSpacing: 0.5,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: addressController.addressPay.value.address,
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
                    ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
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
                                    fontSize: Dimensions.font16,
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
                                            Format.numPrice(listCartPay[index].product.price),
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
                          '${'TheTotalAmount'.tr} ($quantity ${'Product'.tr}):',
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
                          Format.numPrice(totalPrice),
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
                          Format.numPrice(transportFee),
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
                  InkWell(
                    onTap: (){
                      Get.to( const ChooseVoucherScreen(), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeftWithFade);
                    },
                    child: Container(
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if(voucherController.voucherPay.value.id != -1)
                                Text(
                                  '${'Reduce'.tr}: ${Format.numPrice(voucherController.voucherPay.value.discountPrice)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: Dimensions.font14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black2Color,
                                    // letterSpacing: 0.5,
                                  ),
                                ),
                              Icon(
                                Icons.chevron_right,
                                size: Dimensions.w25,
                                color: AppColors.grayColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(voucherController.voucherPay.value.minTotalPrice > untilPrice )
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'NotEligible'.tr,
                          style: TextStyle(
                            fontSize: Dimensions.font12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.orangeColor,
                          ),
                        ),
                      ),
                    ),
                  InkWell(
                    onTap: (){
                      Get.to( const ChoosePaymentScreen(), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeftWithFade);
                    },
                    child: Container(
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Payments'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                              // letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 30),                             
                          SizedBox(  
                            width: Dimensions.w65,
                            height: Dimensions.w65,
                            child: Image(
                              image: AssetImage(invoiceController.payments[invoiceController.paymentIndex.value].icon),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              invoiceController.payments[invoiceController.paymentIndex.value].title.tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: Dimensions.font14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),  
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h65),
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
                              text: voucherController.voucherPay.value.minTotalPrice <= untilPrice 
                                ? Format.numPrice(untilPrice - voucherController.voucherPay.value.discountPrice)
                                : Format.numPrice(untilPrice),
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
                    invoiceController.isLoading.value
                    ? Image.asset(
                        'assets/gif/loading_3_2.gif',
                        height: Dimensions.h50,
                      )
                    : MaterialButton(
                        onPressed: () async {
                          if(addressController.addressPay.value.id == -1){
                            Get.snackbar(
                              'PleaseSelectAddress'.tr,
                              ''.tr,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            return;
                          }
                          if(invoiceController.payments[invoiceController.paymentIndex.value].key == 'tm'){
                            if(voucherController.voucherPay.value.minTotalPrice <= untilPrice && voucherController.voucherPay.value.id != -1) {
                              invoiceController.addInvoice(listCartId, voucherController.voucherPay.value.id, transportFee, addressController.addressPay.value, null, null);
                            }else{
                              invoiceController.addInvoice(listCartId, null, transportFee, addressController.addressPay.value, null, null);
                            }
                          }else if(invoiceController.payments[invoiceController.paymentIndex.value].key == 'zp'){
                            print('zalopay...');
                            int amount;
                            voucherController.voucherPay.value.minTotalPrice <= untilPrice 
                            ? amount = (untilPrice - voucherController.voucherPay.value.discountPrice)
                            : amount = untilPrice;                           
                            
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                              String invoiceCode = getAppTransId();
                              var result = await createOrder(amount, invoiceCode);
                            if (result != null) {
                                Navigator.pop(context);
                                String zpTransToken = result.zptranstoken;
                                print("zpTransToken $zpTransToken'.");
                              FlutterZaloPaySdk.payOrder(zpToken: zpTransToken).listen((event) {
                                setState(() {
                                  switch (event) {
                                    case FlutterZaloPayStatus.cancelled:
                                      showSuccess2('User Huỷ Thanh Toán'.tr, ''.tr);
                                      break;
                                    case FlutterZaloPayStatus.success:
                                      if(voucherController.voucherPay.value.minTotalPrice <= untilPrice && voucherController.voucherPay.value.id != -1) {
                                        invoiceController.addInvoice(listCartId, voucherController.voucherPay.value.id, transportFee, addressController.addressPay.value, invoiceCode, 'ZaloPay');
                                      }else{
                                        invoiceController.addInvoice(listCartId, null, transportFee, addressController.addressPay.value, invoiceCode, 'ZaloPay');
                                      }
                                      break;
                                    case FlutterZaloPayStatus.failed:
                                      showSuccess2('Thanh toán thất bại'.tr, ''.tr);
                                      break;
                                    default:
                                      showSuccess2('Thanh toán thất bại'.tr, ''.tr);
                                      break;
                                  }
                                });
                              });
                            }
                          }
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
                      ),
                  ],
                ),
              ),
            ),
            Container(
              height: invoiceController.isLoading.value?Dimensions.height:0,
              color: AppColors.gray2Color,
            )
          ],
        ),
      );
    });
  }
}
