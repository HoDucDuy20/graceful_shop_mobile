import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/services/remote_service.dart';

class FeedbackController extends GetxController {
  UserController userController = Get.find<UserController>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  static void back() {
    Get.back();
  }

  void sendFeedback(String description) async {
    isLoading.value = true;
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    var responseData = await RemoteService.sendFeedback(userController.token.value, description);
    isLoading.value = false;
    if (responseData != null) {
      if (responseData.status == 0) {
        back();
        showSuccess2('FeedbackSuccessfully'.tr, 'ThanksFeedback'.tr);
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
