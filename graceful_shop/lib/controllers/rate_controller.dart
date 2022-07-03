import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/rate.dart';
import 'package:graceful_shop/models/rate_product.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/rate/rate_tab.dart';
import 'package:graceful_shop/services/remote_service.dart';

class RateController extends GetxController {
  UserController userController = Get.find<UserController>();
  ProductController productController = Get.find<ProductController>();
  var productNotYedRatedList = <Product>[].obs;
  var productRatedList = <RatedProduct>[].obs;
  var rated = Rate(id: -1, numRate: 0, description: '', createdAt: '', picturesRate: []).obs;
  var isLoading = false.obs;
  var isLoadingDetail = false.obs;
  var lstImage = <String>[].obs;
  var txtContent = TextEditingController().obs;
  var star = 0.0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   if (userController.token.value != '') {
  //     productNotYedRated();
  //   }
  // }

   void showRate() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    productNotYedRated();
    productRated();
    Get.to(() => const RateTab());
  }

  void productNotYedRated() async {
    isLoading.value = true;
    var products = await RemoteService.productNotYedRated(userController.token.value);
    if (products != null) {
      productNotYedRatedList.value = products;
    }
    isLoading.value = false;
  }

  void productRated() async {
    isLoading.value = true;
    var products = await RemoteService.productRated(userController.token.value);
    if (products != null) {
      productRatedList.value = products;
    }
    isLoading.value = false;
  }

  void rateProduct(int productId, int numRate, String description, List<String>? images) async {
    isLoading.value = true;
    var responseDataInfo = await RemoteService.rateProduct(userController.token.value, productId, numRate, description, images!);
    if (responseDataInfo != null) {
      if (responseDataInfo.status != 0) {
        isLoading.value = false;
        Get.snackbar(
          'FailedAction'.tr,
          responseDataInfo.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        productNotYedRated();
        productRated();
        Get.back();
        toastSuccess('SuccessfulEvaluation'.tr);
        // Future.delayed(const Duration(milliseconds: 300), Get.back);
        isLoading.value = false;
      }
      return;
    }
    isLoading.value = false;
    Get.snackbar(
      'FailedAction'.tr,
      'AnErrorOccurred'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void editRateProduct(int rateId, int productId, int numRate, String description, List<String>? images) async {
    isLoading.value = true;
    var responseDataInfo = await RemoteService.editRateProduct(userController.token.value, rateId, productId, numRate, description, images!);
    if (responseDataInfo != null) {
      if (responseDataInfo.status != 0) {
        isLoading.value = false;
        Get.snackbar(
          'FailedAction'.tr,
          responseDataInfo.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        productController.getRateOfProduct(productId);
        productNotYedRated();
        productRated();
        Get.back();
        toastSuccess('SuccessfulEvaluation'.tr);
        // Future.delayed(const Duration(milliseconds: 300), Get.back);
        isLoading.value = false;
      }
      return;
    }
    isLoading.value = false;
    Get.snackbar(
      'FailedAction'.tr,
      'AnErrorOccurred'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void ratedDetail(int rateId) async {
    isLoadingDetail.value = true;
    lstImage.value = [];
    txtContent.value.text = '';
    star.value = 0.0;
    var rate = await RemoteService.ratedDetail(userController.token.value, rateId);
    if (rate != null) {
      rated.value = rate;
      txtContent.value.text = rated.value.description;
      star.value = rated.value.numRate;
      for (var img in rate.picturesRate) {
        lstImage.add(img.pictureValue);
      }
    }
    isLoading.value = false;
  }
}
