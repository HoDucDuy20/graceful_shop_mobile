import 'dart:io';

import 'package:get/get.dart';
import 'package:graceful_shop/controllers/favorite_controller.dart';
import 'package:graceful_shop/models/user.dart';
import 'package:graceful_shop/screens/login/login.dart';
import 'package:graceful_shop/screens/tab_bar/tab_bar.dart';
import 'package:graceful_shop/services/remote_service.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var token = ''.obs;
  var isLoading = false.obs;
  var user = User(id: -1, fullName: '', phone: '', avatar: '').obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  void setToken(String _token) async {
    token.value = _token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
  }

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? '';
    getUserInfo();
    Get.put(FavoriteController());
  }

  void getSex() async {
    if (user.value.sex == 0)
      user.value.sexName = 'Male'.tr;
    else if (user.value.sex == 1)
      user.value.sexName = 'Female'.tr;
    else
      user.value.sexName = '';
  }

  void logIn(String phone, String pass) async {
    isLoading.value = true;
    var responseData = await RemoteService.logIn(phone, pass);
    if (responseData != null) {
      int status = responseData.status;
      if (status == 0) {
        setToken(responseData.data);
        getUserInfo();
        Get.offAll(() => TabBarBottom(index: 3));
      } else {
        Get.snackbar(
          'LoginFailed'.tr,
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
    isLoading.value = false;
  }

  void register(String name, String phone, String pass) async {
    isLoading.value = true;
    var responseData = await RemoteService.register(name, phone, pass);
    if (responseData != null) {
      int status = responseData.status;
      if (status == 0) {
        setToken(responseData.data);
        Get.off(() => const Login());
        Get.snackbar(
          'SignUpSuccess'.tr,
          'FillInInformation'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'RegistrationFailed'.tr,
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
    isLoading.value = false;
  }

  void logOut() async {
    isLoading.value = true;
    var responseData = await RemoteService.logOut(token.value);
    if (responseData != null) {
      setToken('');
      Get.to(() => const Login());
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  void getUserInfo() async {
    if (token.value != '') {
      var userInfo = await RemoteService.getUserInfo(token.value);
      if (userInfo != null) {
        user.value = userInfo;
        getSex();
      } else {
        setToken('');
        Get.snackbar(
          'FailedAction'.tr,
          'AnErrorOccurred'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void updateProfile(File? image) async {
    isLoading.value = true;
    if (token.value != '') {
      if (image != null) {
        var responseDataAvatar =
            await RemoteService.changeAvatar(token.value, image.path);
        var responseDataInfo =
            await RemoteService.changeInfo(token.value, user.value);
        if (responseDataInfo != null && responseDataAvatar != null) {
          if (responseDataInfo.status != 0) {
            isLoading.value = false;
            Get.snackbar(
              'FailedAction'.tr,
              responseDataInfo.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          if (responseDataAvatar.status != 0) {
            isLoading.value = false;
            Get.snackbar(
              'FailedAction'.tr,
              responseDataAvatar.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
          if (responseDataInfo.status == 0 && responseDataAvatar.status == 0) {
            getUserInfo();
            getSex();
            Get.back();
            isLoading.value = false;
          }
          return;
        }
      } else {
        var responseDataInfo =
            await RemoteService.changeInfo(token.value, user.value);
        if (responseDataInfo != null) {
          if (responseDataInfo.status != 0) {
            isLoading.value = false;
            Get.snackbar(
              'FailedAction'.tr,
              responseDataInfo.message,
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            getUserInfo();
            getSex();
            Get.back();
            isLoading.value = false;
          }
          return;
        }
      }
      isLoading.value = false;
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void changePass(String oldPass, String newPass) async {
    isLoading.value = true;
    var responseData =
        await RemoteService.changePass(token.value, oldPass, newPass);
    if (responseData != null) {
      int status = responseData.status;
      if (status == 0) {
        setToken('');
        Get.offAll(() => TabBarBottom(index: 3));
        Get.snackbar(
          'ChangePasswordSuccessfully'.tr,
          'PleaseLogInAgain'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'ChangePasswordFailed'.tr,
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
    isLoading.value = false;
  }
}
