import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/services/remote_service.dart';

class ProductController extends GetxController {
  UserController userController = Get.find<UserController>();
  var productList = <Product>[].obs;
  var productListSearch = <Product>[].obs;
  var colorList = <ProductColor>[].obs;
  var sizeList = <ProductSize>[].obs;
  var quantity = 1.obs;
  var quantityOfType = <QuantityOfType>[].obs;
  var tab = 0.obs;
  var page = 1.obs;
  var pageSearch = 1.obs;
  var loading = false.obs;
  var total = (-1).obs;
  var totalSearch = 0.obs;
  var checkFull = false.obs;
  var checkFullSearch = false.obs;
  var indexColor = 0.obs;
  var indexSize = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getPopularProducts();
  }

  void reset() {
    total.value = -1;
    page.value = 1;
    productList.value = [];
  }

  void resetSearch() {
    totalSearch.value = -1;
    pageSearch.value = 1;
    productListSearch.value = [];
  }

  void getPopularProducts() async {
    var productTotal = await RemoteService.getPopularProducts(page.value);
    if (productTotal != null) {
      total.value = productTotal.total;
      page.value++;
      productTotal.products.forEach((value) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      });
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
      productTotal.products.forEach((value) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      });
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

  void searchProducts(String value) async {
    var productTotal =
        await RemoteService.searchProducts(value, pageSearch.value);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      productTotal.products.forEach((value) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      });
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length
          ? checkFullSearch.value = true
          : checkFullSearch.value = false;
      loading.value = false;
    }
  }

  void getProductsOfType(int typeId) async {
    var productTotal =
        await RemoteService.getProductsOfType(typeId, pageSearch.value);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      productTotal.products.forEach((value) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      });
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length
          ? checkFullSearch.value = true
          : checkFullSearch.value = false;
      loading.value = false;
    }
  }

  void getProductsOfAllType(int typeId) async {
    var productTotal =
        await RemoteService.getProductsOfAllType(typeId, pageSearch.value);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      productTotal.products.forEach((value) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      });
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length
          ? checkFullSearch.value = true
          : checkFullSearch.value = false;
      loading.value = false;
    }
  }
}
