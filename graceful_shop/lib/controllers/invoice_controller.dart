import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/services/remote_service.dart';

class InvoiceController extends GetxController {
  UserController userController = Get.find<UserController>();
  var productCartList = <Cart>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  static void back() {
    Get.back();
  }

  void showInvoice() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    // getProductCart();
    // Get.to(() => const CartScreen());
  }

  void addInvoice(List<int> lstCartId, int? voucherId, int shipPrice) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    back();
    var responseData = await RemoteService.addInvoice(userController.token.value, lstCartId, voucherId, shipPrice);
    if (responseData != null) {
      if (responseData.status == 0) {
        back();
        showSuccess('OrderSuccess'.tr);
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

  void getProductCart() async {
    var products = await RemoteService.getProductCart(userController.token.value);
    if (products != null) {
      for (var value in products) {
        value.product.isLike = value.product.likes.firstWhere((x) => x.userId == userController.user.value.id, orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productCartList.value = products;
    }
  }

  void cancelInvoice(List<int> lstCartId) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }

    var responseData = await RemoteService.deleteCart(userController.token.value, lstCartId);

    if (responseData != null) {
      if (responseData.status != 0) {
        getProductCart();
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }else{
        getProductCart();
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
