import 'package:get/get.dart';
import 'package:graceful_shop/models/info_shop.dart';
import 'package:graceful_shop/services/remote_service.dart';

class InfoShopController extends GetxController {
  var infoShop = InfoShop(address: '', addressMap: '', messChat: '', messManager: '', pageFb: '', phone: '').obs;

  @override
  void onInit() {
    super.onInit();
    getInfoShop();
  }

  static void back() {
    Get.back();
  }

  void showInfoShop() {
    getInfoShop();
    // Get.to(() => const InfoShopScreen());
  }

  void getInfoShop() async {
    var infoShops = await RemoteService.getInfoShop();
    if (infoShops != null) {
      infoShop.value = infoShops;
    }
  }

}
