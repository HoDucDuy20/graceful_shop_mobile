import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/rate/rate_tab.dart';
import 'package:graceful_shop/services/remote_service.dart';

class RateController extends GetxController {
  UserController userController = Get.find<UserController>();
  var productNotYedRatedList = <Product>[].obs;
  var productRatedList = <Product>[].obs;
  var isLoading = false.obs;

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
}
