import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/screens/cart/cart.dart';
import 'package:graceful_shop/services/remote_service.dart';

class CartController extends GetxController {
  UserController userController = Get.find<UserController>();
  var productCartList = <Cart>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getProductCart();
  }

  static void back() {
    Get.back();
  }

  void showCart() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    getProductCart();
    Get.to(const CartScreen(), duration: const Duration(milliseconds: 700), transition: Transition.upToDown);
  }

  void addCart(int productId, int colorId, int sizeId, int quantity) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    back();
    var responseData = await RemoteService.addCart(
        userController.token.value, productId, colorId, sizeId, quantity);
    if (responseData != null) {
      if (responseData.status == 0) {
        toastSuccess('AddedToCart'.tr);
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

  void updateCart(int index) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    var responseData = await RemoteService.updateCart(
          userController.token.value,
          productCartList[index].productId,
          productCartList[index].colorId,
          productCartList[index].sizeId,
          productCartList[index].quantity,
        );
    
    if(productCartList[index].quantity < 1){
      productCartList.remove(productCartList[index]);
    }

    if (responseData != null) {
      if (responseData.status != 0) {
        getProductCart();
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
    isLoading.value = true;
    var products = await RemoteService.getProductCart(userController.token.value);
    if (products != null) {
      for (var value in products) {
        value.product.isLike = value.product.likes.firstWhere((x) => x.userId == userController.user.value.id, orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productCartList.value = products;
    }
    isLoading.value = false;
  }

  void reduceTheNumber(int index) {
    if (productCartList[index].quantity > 1) {
      productCartList[index].quantity--;
      updateCart(index);
    } else {
      confirmDelete(index);
    }
  }

  void increasingTheNumber(int index) {
    if (productCartList[index].quantity < 500) {
      productCartList[index].quantity++;
      updateCart(index);
    }
  }

  void deleteCart(List<int> lstCartId) async {
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
