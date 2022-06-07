import 'package:get/get.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/services/remote_service.dart';

class SlideAdsController extends GetxController {
  var slideAdsList = <SlideAds>[].obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    getSlideAds();
  }

  void getSlideAds() async {
    var slideAds = await RemoteService.getSlideAds();
    if (slideAds != null) {
      slideAdsList.value = slideAds;
    }
  }

  void getSlideAdsDetail(int id) async {
    productList.value = [];
    var products = await RemoteService.getSlideAdsDetail(id);
    if (products != null) {
      productList.value = products;
    }
  }
}
