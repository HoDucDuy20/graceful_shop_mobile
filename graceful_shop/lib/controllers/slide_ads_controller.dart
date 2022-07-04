import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/services/remote_service.dart';

class SlideAdsController extends GetxController {
  UserController userController = Get.find<UserController>();
  var slideAdsList = <SlideAds>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSlideAds();
  }

  void getSlideAds() async {
    slideAdsList.value = [];
    var slideAds = await RemoteService.getSlideAds();
    if (slideAds != null) {
      slideAdsList.value = slideAds;
    }
  }
}
