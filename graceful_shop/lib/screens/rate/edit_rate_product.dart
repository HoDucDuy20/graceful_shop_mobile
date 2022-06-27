import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:graceful_shop/resources/utils/dimensions.dart';
import 'package:graceful_shop/resources/utils/format.dart';
import 'package:graceful_shop/screens/product_detail/product_detail.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:image_picker/image_picker.dart';

class EditRateProduct extends StatefulWidget {
  EditRateProduct({Key? key, required this.product}) : super(key: key);
  Product product;

  @override
  _EditRateProductState createState() => _EditRateProductState(product: product);
}

class _EditRateProductState extends State<EditRateProduct> {
  _EditRateProductState({Key? key, required this.product});
  RateController rateController = Get.find<RateController>();
  UserController userController = Get.find<UserController>();
  Product product;
  final ImagePicker _picker = ImagePicker();

  var errorFeedback = ''.obs;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {});
  //   rateController.star.value = rateController.rated.value.numRate;
  //   rateController.txtContent.value..text = rateController.rated.value.description;
  // }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Obx(() {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.greenColor,
              onPressed: () async {
                try {
                  if (rateController.lstImage.length > 5) {
                      Get.snackbar(
                      '3Photos'.tr,
                      ''.tr,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } else {
                    final List<XFile>? selectedImages = await _picker.pickMultiImage();
                    if (selectedImages!.isNotEmpty) {
                      for (var img in rateController.lstImage) {
                        if(!img.contains('graceful_shop/cache/')){
                          rateController.lstImage.value = [];
                          break;
                        }
                      }
                      for (var img in selectedImages) {
                        setState(() {});
                        if(rateController.lstImage.length > 5){
                          Get.snackbar(
                            'MaxPhotos'.tr,
                            ''.tr,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          break;
                        }
                        rateController.lstImage.add(img.path);
                      } 
                    }
                  }
                } catch (e) {}
              },
              child: const Icon(Icons.add_photo_alternate_rounded),
            ),
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
                    'Rate'.tr,
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: rateController.isLoading.value
                      ? Image.asset(
                          'assets/gif/loading_3_2.gif',
                          height: Dimensions.h40,
                        )
                      : MaterialButton(
                          onPressed: () async {
                            if (rateController.star.value == 0) {
                              Get.snackbar(
                                'YouHaveNotStars'.tr,
                                'PleaseVote'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            } 
                            if (rateController.txtContent.value.text == '') {
                              errorFeedback.value = 'ContentNotEmpty'.tr;
                              return;
                            }
                          
                            FocusScope.of(context).requestFocus(FocusNode());
                            rateController.editRateProduct(rateController.rated.value.id ,product.id, rateController.star.value.toInt(), rateController.txtContent.value.text, rateController.lstImage);                        
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35.0),
                              bottomLeft: Radius.circular(35.0)
                            ),
                          ),
                          color: AppColors.mainColor,
                          height: Dimensions.h40,
                          child: Text(
                            'Edit'.tr,
                            style: TextStyle(
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(() => ProductDetail(product: product));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: Dimensions.h10),
                      color: AppColors.gray3Color,
                      child: ListTile(
                        leading: SizedBox(
                          child: FadeInImage.assetNetwork(
                            width: Dimensions.w65,
                            height: Dimensions.w100,
                            placeholder: 'assets/gif/loading_2.gif',
                            image: formaterImg(
                              product.pictures[0].pictureValue,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product.productName,
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
                              Format.numPrice(product.price),
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
                          Icons.remove_red_eye_outlined,
                          color: AppColors.mainColor,
                        ),                      
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.blueAccentColor,
                      backgroundImage: FadeInImage.assetNetwork(
                        placeholder: 'assets/gif/loading_2.gif',
                        image: formaterImg(userController.user.value.avatar),
                        fit: BoxFit.cover,
                      ).image
                    ),
                    title: Text(
                      userController.user.value.fullName,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: Dimensions.font17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                        letterSpacing: 0.7,
                      ),
                    ),
                    subtitle: Text(
                      Format.dateTime(DateTime.now().toString()),
                      style: TextStyle(
                        height: 1.5,
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black2Color,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.w10),
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        RatingBar.builder(
                          initialRating: rateController.star.value,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: Dimensions.w5, vertical: Dimensions.h7),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: AppColors.yellowColor,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              rateController.star.value = rating;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.gray3Color,
                    child: TextField(
                      controller: rateController.txtContent.value,
                      // autofocus: true,
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: Dimensions.font17,
                        color: AppColors.black2Color,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hoverColor: AppColors.black2Color,
                        hintText: '${'MoreContent'.tr}...',
                        errorText: errorFeedback.value == '' ? null : errorFeedback.value,
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
                      mainAxisExtent: Dimensions.h200,
                    ),
                    itemCount:  rateController.lstImage.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15, vertical: Dimensions.h12),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                width: double.infinity,
                                height: Dimensions.h200,
                                child: rateController.lstImage[index].contains('graceful_shop/cache/')
                                  ? Image.file(
                                      File(rateController.lstImage[index]),
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage.assetNetwork(
                                      placeholder: 'assets/gif/loading_2.gif',
                                      image: formaterImg(rateController.lstImage[index]),
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 0,
                              child: CircleAvatar(
                                backgroundColor: AppColors.greenColor,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      rateController.lstImage.remove(rateController.lstImage[index]);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 25,
                                  ),
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
          );
        }
      ),
    );
  }
}
