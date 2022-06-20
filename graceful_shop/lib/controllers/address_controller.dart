import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/address.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/address/address.dart';
import 'package:graceful_shop/services/remote_service.dart';

class AddressController extends GetxController {
  UserController userController = Get.find<UserController>();
  var addressList = <Address>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  static void back() {
    Get.back();
  }

  void showAddress() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    getAddress();
    Get.to(() => const AddressScreen());
  }

  void addAddress(Address address) async {
    isLoading.value = true;
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    var responseData = await RemoteService.addAddress(userController.token.value, address);
    isLoading.value = false;
    if (responseData != null) {
      getAddress();
      if (responseData.status == 0) {
        back();
        showSuccess('AddressSuccess'.tr);
        Future.delayed(const Duration(milliseconds: 300), back);
      } else {
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void getAddress() async {
    var addresses = await RemoteService.listAddress(userController.token.value);
    if (addresses != null) {
      // Address address = Address(
      //   id: -1, 
      //   name: userController.user.value.fullName, 
      //   address: userController.user.value.address, 
      //   phoneNumber: userController.user.value.phone, 
      //   isDefault: true,
      // );
      addressList.value = [];
      // for (var value in addresses) {
      //   if(value.isDefault){
      //     address.isDefault = false;
      //     break;
      //   }
      // }
      // if(address.address.isNotEmpty){
      //    addressList.add(address);
      // }     
      addressList.addAll(addresses);
    }
  }

  void editAddress(Address address) async {
    isLoading.value = true;
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    var responseData = await RemoteService.editAddress(userController.token.value, address);
    isLoading.value = false;
    if (responseData != null) {
      getAddress();
      if (responseData.status == 0) {
        back();
        showSuccess('EditAddressSuccess'.tr);
        Future.delayed(const Duration(milliseconds: 300), back);
      } else {
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deleteAddress(Address address) async {
    isLoading.value = true;
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    back();
    var responseData = await RemoteService.deleteAddress(userController.token.value, address.id);
    isLoading.value = false;
    if (responseData != null) {
      getAddress();
      if (responseData.status == 0) {
        back();
        showSuccess('DeleteAddressSuccess'.tr);
        Future.delayed(const Duration(milliseconds: 300), back);
      } else {
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
