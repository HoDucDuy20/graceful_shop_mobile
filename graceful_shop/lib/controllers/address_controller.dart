import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/address.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/address/address.dart';
import 'package:graceful_shop/services/remote_service.dart';

class AddressController extends GetxController {
  UserController userController = Get.find<UserController>();
  var addressPay = Address(id: -1, name: '', address: '', phoneNumber: '', isDefault: false).obs;
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
        toastSuccess('AddressSuccess'.tr);
        // Future.delayed(const Duration(milliseconds: 300), back);
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

  void checkAddressPay(){
    bool check = false;
    for(var value in addressList){
      if(value.isDefault){
        addressPay.value = value;
        check = true;
        break;
      }
    }

    if(!check){
      addressPay.value = Address(id: -1, name: '', address: '', phoneNumber: '', isDefault: false);
    }
  }

  void getAddress() async {
    var addresses = await RemoteService.listAddress(userController.token.value);
    if (addresses != null) {
      addressList.value = addresses;
      checkAddressPay();
    }
  }
  
  void addAddressPay(Address address) {
    addressPay.value = address;
    Get.back();
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
        toastSuccess('EditAddressSuccess'.tr);
        // Future.delayed(const Duration(milliseconds: 300), back);
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
        toastSuccess('DeleteAddressSuccess'.tr);
        // Future.delayed(const Duration(milliseconds: 300), back);
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
