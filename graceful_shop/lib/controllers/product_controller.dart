import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/product_type.dart';
import 'package:graceful_shop/models/rate.dart';
import 'package:graceful_shop/services/remote_service.dart';

class ProductController extends GetxController {
  UserController userController = Get.find<UserController>();
  var productList = <Product>[].obs;
  var productListSearch = <Product>[].obs;
  var productTypeListSearch = <ProductType>[].obs;
  var productAllType = <Product>[].obs;
  var colorList = <ProductColor>[].obs;
  var sizeList = <ProductSize>[].obs;
  var rateList = <Rate>[].obs;
  var quantity = 1.obs;
  var quantityOfType = <QuantityOfType>[].obs;
  var tab = 0.obs;
  var page = 1.obs;
  var pageSearch = 1.obs;
  var loading = false.obs;
  var total = (-1).obs;
  var totalSearch = 0.obs;
  var totalProductAllType = 0.obs;
  var checkFull = false.obs;
  var checkFullSearch = false.obs;
  var indexColor = 0.obs;
  var indexSize = 0.obs;
  var numOrder = 0.obs;

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
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productList.addAll(productTotal.products); 
      total.value == productList.length ? checkFull.value = true : checkFull.value = false;
      loading.value = false;
    }
  }

  void getNewProducts() async {
    var productTotal = await RemoteService.getNewProducts(page.value);
    if (productTotal != null) {
      total.value = productTotal.total;
      page.value++;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productList.addAll(productTotal.products);
      total.value == productList.length ? checkFull.value = true : checkFull.value = false;
      loading.value = false;
    }
  }

  void getSellingProducts() async {
    var productTotal = await RemoteService.getSellingProducts(page.value);
    if (productTotal != null) {
      total.value = productTotal.total;
      page.value++;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productList.addAll(productTotal.products); 
      total.value == productList.length ? checkFull.value = true : checkFull.value = false;
      loading.value = false;
    }
  }

  void getColorSize(int productId) async {
    indexColor.value = 0;
    indexSize.value = 0;
    quantity.value = 1;
    colorList.value = [];
    sizeList.value = [];
    numOrder.value = 0;
    // quantityOfType.value = [];
    var newColorSize = await RemoteService.getColorSize(productId);
    if (newColorSize != null) {
      colorList.value = newColorSize.colors;
      sizeList.value = newColorSize.sizes;
      // quantityOfType.value = newColorSize.quantityOfType;
      numOrder.value = newColorSize.numOrder;
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

  void searchProductType(String value) async {
    productTypeListSearch.value = [];
    var productTypes = await RemoteService.searchProductType(value);
    if (productTypes != null) {
      productTypeListSearch.value = productTypes;
    }
  }

  void searchProducts(String value, int? productTypeId, int? fromPrice, int? toPrice, bool newSort, int priceSort) async {
    loading.value = true;
    var productTotal = await RemoteService.searchProducts(value, pageSearch.value, productTypeId, fromPrice, toPrice, newSort, priceSort);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length ? checkFullSearch.value = true : checkFullSearch.value = false;
      loading.value = false;
    }
  }

  void getProductsOfType(int typeId) async {
    loading.value = true;
    var productTotal =
        await RemoteService.getProductsOfType(typeId, pageSearch.value);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length ? checkFullSearch.value = true : checkFullSearch.value = false;
      loading.value = false;
    }
  }

  void getProductsOfAllType(int typeId) async {
    var productTotal = await RemoteService.getProductsOfAllType(typeId, pageSearch.value);
    if (productTotal != null) {
      totalSearch.value = productTotal.total;
      pageSearch.value++;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productListSearch.addAll(productTotal.products);
      totalSearch.value == productListSearch.length ? checkFullSearch.value = true : checkFullSearch.value = false;
      loading.value = false;
    }
  }

   void getProductsOfAllType2(int typeId) async {
    totalProductAllType.value = -1;
    productAllType.value = [];
    var productTotal = await RemoteService.getProductsOfAllType(typeId, 1);    
    if (productTotal != null) {
      totalProductAllType.value = productTotal.total;
      for (var value in productTotal.products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productAllType.value = productTotal.products;
      loading.value = false;
    }
  }

  void getRateOfProduct(int productId) async {
    rateList.value = [];
    var rates = await RemoteService.getRateOfProduct(productId);
    if (rates != null) {
      rateList.value = rates;
    }
  }

  void getSlideAdsDetail(int id) async {
    productListSearch.value = [];
    var products = await RemoteService.getSlideAdsDetail(id);
    if (products != null) {
      for (var value in products) {
         value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id , orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      productListSearch.value = products;
    }
  }
}
