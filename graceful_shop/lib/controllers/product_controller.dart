import 'package:get/get.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/services/remote_service.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var colorList = <ProductColor>[].obs;
  var sizeList = <ProductSize>[].obs;
  var quantity = 1.obs;
  var quantityOfType = <QuantityOfType>[].obs;
  var tab = 0.obs;
  var page = 1.obs;
  var loading = false.obs;
  var total = 0.obs;
  var checkFull = false.obs;
  var indexColor = 0.obs;
  var indexSize = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getPopularProducts();
  }

  void getPopularProducts() async {
    var productTotal = await RemoteService.getPopularProducts(page.value);
    if (productTotal != null) {
      total.value = productTotal.total;
      page.value++;
      productList.addAll(productTotal.products);
      total.value == productList.length
          ? checkFull.value = true
          : checkFull.value = false;
      loading.value = false;
    }
  }

  void getNewProducts() async {
    var productTotal = await RemoteService.getNewProducts(page.value);
    if (productTotal != null) {
      total.value = productTotal.total;
      page.value++;
      productList.addAll(productTotal.products);
      total.value == productList.length
          ? checkFull.value = true
          : checkFull.value = false;
      loading.value = false;
    }
  }

  void getColorSize() async {
    indexColor.value = 0;
    indexSize.value = 0;
    quantity.value = 1;
    colorList.value = [];
    sizeList.value = [];
    quantityOfType.value = [];
    var newColorSize = await RemoteService.getColorSize(page.value);
    if (newColorSize != null) {
      colorList.value = newColorSize.colors;
      sizeList.value = newColorSize.sizes;
      quantityOfType.value = newColorSize.quantityOfType;
    }
  }

  void reduceTheNumber() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void increasingTheNumber() {
    if (quantity.value < 500) {
      quantity.value++;
    }
  }
}
