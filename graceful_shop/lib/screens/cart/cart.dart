import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/cart_controller.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/screens/pay/pay.dart';
import 'package:graceful_shop/services/url.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find<CartController>();
  List<int> listCartId = [];
  List<Cart> listCartPay = [];
  int totalPrice = 0;
  bool isCheckAll = false;

  void checkAll(){
    setState(() {});
    listCartId = [];
    totalPrice = 0;
    isCheckAll = !isCheckAll;
    if(isCheckAll)
    {     
      for (var i = 0; i < cartController.productCartList.length; i++) {
        cartController.productCartList[i].check = true;
        totalPrice += cartController.productCartList[i].quantity * cartController.productCartList[i].product.price;
        listCartId.add(cartController.productCartList[i].id);
      }
    }else{
      for (var i = 0; i < cartController.productCartList.length; i++) {
        cartController.productCartList[i].check = false;
      }
    }    
  }

  void updateListCartId(){
    listCartId = [];
    for (var i = 0; i < cartController.productCartList.length; i++) {
      if(cartController.productCartList[i].check == true)
      {
          listCartId.add(cartController.productCartList[i].id);
      }                              
    }
  }

  void updateListCartPay(){
    totalPrice = 0;
    listCartId = [];
    listCartPay = [];
    for (var i = 0; i < cartController.productCartList.length; i++) {
      if(cartController.productCartList[i].check == true)
      {   
        totalPrice += cartController.productCartList[i].quantity * cartController.productCartList[i].product.price;
        listCartId.add(cartController.productCartList[i].id);
        listCartPay.add(cartController.productCartList[i]);
      }                              
    }
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
              'Cart'.tr,
              style: TextStyle(
                fontSize: Dimensions.font20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          if(listCartId.isNotEmpty)
          InkWell(
            onTap: () async {
              await Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(top: Dimensions.h7),
                  actionsPadding: EdgeInsets.zero,
                  content: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h10, horizontal: Dimensions.w25),
                    child: Text(
                      'AreYouSureQuitProduct'.tr,
                      style: TextStyle(
                        color: AppColors.black2Color,
                        fontSize: Dimensions.font15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'No'.tr,
                              style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {                  
                              cartController.deleteCart(listCartId);
                              totalPrice = 0;
                              listCartId = [];
                              listCartPay = [];
                              Get.back();
                            },
                            child: Text(
                              'Yes'.tr,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
              child: Icon(
                Icons.delete_outlined, 
                color: AppColors.orangeColor,
                size: Dimensions.font30,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Obx(() {
                  return cartController.isLoading.value
                      ? Center(
                          child: SizedBox(
                            // height: Dimensions.h100,
                            width: Dimensions.w210,
                            child: Image.asset(
                                'assets/gif/loading_4.gif',
                              ),
                          ),
                        )
                      : cartController.productCartList.isEmpty
                        ? Padding(
                          padding: EdgeInsets.only(top: Dimensions.h65),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: Dimensions.h200,
                                width: Dimensions.w210,
                                child: const Image(
                                  image: AssetImage('assets/images/no-product-found.png'),
                                ),
                              ),
                            ),
                        )
                        : Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                            shrinkWrap: true,
                            itemCount: cartController.productCartList.length,
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
                                    SizedBox(
                                      width: Dimensions.w30,
                                      child: Checkbox(
                                        checkColor: AppColors.whiteColor,
                                        activeColor: AppColors.orangeColor,
                                        value: cartController.productCartList[index].check,
                                        onChanged: (value) {
                                          setState(() {});
                                          cartController.productCartList[index].check = value ?? false;
                                          if (cartController.productCartList[index].check) {
                                            updateListCartId();
                                            totalPrice += cartController.productCartList[index].quantity * cartController.productCartList[index].product.price;
                                            isCheckAll = listCartId.length == cartController.productCartList.length;
                                          } else {
                                            listCartId = [];
                                            updateListCartId();
                                            totalPrice -= cartController.productCartList[index].quantity * cartController.productCartList[index].product.price;
                                            isCheckAll = listCartId.length == cartController.productCartList.length;
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        leading: SizedBox(
                                          child: FadeInImage.assetNetwork(
                                            width: Dimensions.w65,
                                            height: Dimensions.w100,
                                            placeholder: 'assets/gif/loading_2.gif',
                                            image: formaterImg(
                                              cartController.productCartList[index].color.picture,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(
                                          cartController.productCartList[index].product.productName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            height: 1.7,
                                            fontSize: Dimensions.font17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black2Color,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                              color: AppColors.gray2Color,
                                              child: Text(
                                                '${'Classify'.tr}: ${cartController.productCartList[index].color.colorName} / ${cartController.productCartList[index].size.sizeName}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: Dimensions.font14,
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.grayColor,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: Dimensions.h7),
                                              child: Row(
                                                children: [
                                                  // if (cartController.productCartList[index].product.discountPrice != 0)
                                                  //   Padding(
                                                  //     padding: EdgeInsets.only(right: Dimensions.w7),
                                                  //     child: Text(
                                                  //       Format.numPrice(cartController.productCartList[index].product.discountPrice + cartController.productCartList[index].product.price),
                                                  //       maxLines: 1,
                                                  //       overflow: TextOverflow.ellipsis,
                                                  //       style: TextStyle(
                                                  //         decoration: TextDecoration.lineThrough,
                                                  //         fontSize: Dimensions.font14,
                                                  //         fontWeight: FontWeight.w300,
                                                  //         fontStyle: FontStyle.italic,
                                                  //         color: AppColors.grayColor,
                                                  //         letterSpacing: 0.5,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  Text(
                                                    Format.numPrice(cartController.productCartList[index].product.price),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.font15,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.redColor,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: Dimensions.h5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.gray2Color,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {});
                                                      if (cartController.productCartList[index].check) {
                                                        totalPrice -= cartController.productCartList[index].product.price;
                                                      }
                                                      cartController.reduceTheNumber(index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors.gray2Color,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons.remove_outlined,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.w35,
                                                    child: Text(
                                                      cartController.productCartList[index].quantity.toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.orangeColor,
                                                        letterSpacing: 0.5,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {});
                                                      if (cartController.productCartList[index].check) {
                                                        totalPrice += cartController.productCartList[index].product.price;
                                                      }
                                                      cartController.increasingTheNumber(index);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors.gray2Color,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        Icons.add_outlined,
                                                      ),
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
                            padding: EdgeInsets.symmetric(vertical: Dimensions.h7, horizontal: Dimensions.w15),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.gray2Color,
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.h80,
                          ),
                        ],
                      );
                }),
              ),
              if(cartController.productCartList.isNotEmpty)
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w10, top: 6),
                              child: SizedBox(
                                width: Dimensions.w30,
                                child: Checkbox(
                                  checkColor: AppColors.whiteColor,
                                  activeColor: AppColors.orangeColor,
                                  value: isCheckAll,
                                  onChanged: (value) {
                                    checkAll();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'All'.tr,
                                style: TextStyle(
                                  height: 1.7,
                                  fontSize: Dimensions.font14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black2Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                Format.numPrice(totalPrice),
                                style: TextStyle(
                                  height: 1.7,
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: (){
                                updateListCartPay();
                                if(listCartId.isNotEmpty) {
                                  Get.to(PayScreen(listCartPay: listCartPay), duration: const Duration(milliseconds: 400), transition: Transition.rightToLeftWithFade);
                                }
                              },
                              color: AppColors.redColor,
                              height: Dimensions.h65,
                              child: Text(
                                '${'BuyProduct'.tr} ( ${listCartId.length} )',
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
          );
        }
      ),
    );
  }
}
