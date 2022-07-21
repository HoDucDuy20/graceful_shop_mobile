import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/services/remote_service.dart';

class FavoriteController extends GetxController {
  UserController userController = Get.find<UserController>();
  ProductController productController = Get.find<ProductController>();
  var producFavoritetList = <Product>[].obs;
  var isLoading = false.obs;
  Product p = Product(
    id: -1,
    productName: '',
    price: 0,
    productTypeId: 0,
    productBarcode: '',
    brandId: -1,
    popular: 0,
    numLike: 0,
    numRate: 0,
    description: '',
    pictures: [],
    likes: [],
    quantityStatus: 1,
  );

  @override
  void onInit() {
    super.onInit();
    if (userController.token.value != '') {
      getProductLike();
    }
  }

  void getProductLike() async {
    isLoading.value = true;
    var products = await RemoteService.getProductFavorite(userController.token.value);
    if (products != null) {
      for (var value in products) {
        value.isLike = value.likes.firstWhere((x) => x.userId == userController.user.value.id, orElse: () => Like(productId: -1, userId: -1)).productId != -1;
      }
      producFavoritetList.value = products;
    }
    isLoading.value = false;
  }

  void like(int index) async {
    if (userController.token.value == '') {
      showLogIn();
    } else {
      var responseData = await RemoteService.favorite(userController.token.value, productController.productList[index].id);
      if (responseData != null) {
        if (responseData.status == 0) {
          productController.productList[index].isLike = !productController.productList[index].isLike;
          if (productController.productList[index].isLike) {
            var product = producFavoritetList.firstWhere((x) => x.id == productController.productList[index].id, orElse: () => p);
            if (product.id != -1) {
              producFavoritetList.remove(product);
            }
          } else {
            producFavoritetList.add(productController.productList[index]);
          }
          productController.productList[index].isLike = !productController.productList[index].isLike;
          return;
        }
      }
      productController.productList[index].isLike = !productController.productList[index].isLike;
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void likeSearch(int index) async {
    if (userController.token.value == '') {
      showLogIn();
    } else {
      var responseData = await RemoteService.favorite(userController.token.value, productController.productListSearch[index].id);
      if (responseData != null) {
        // productController.productListSearch[index].isLike =
        //     !productController.productListSearch[index].isLike;
        if (responseData.status == 0) {
          if (!productController.productListSearch[index].isLike) {            
            var product = producFavoritetList.firstWhere((x) => x.id == productController.productListSearch[index].id, orElse: () => p);
            if (product.id != -1) {
              producFavoritetList.remove(product);
            }
          } else {
            producFavoritetList.add(productController.productListSearch[index]);
          }
          for (var value in productController.productList) {
            if (value.id == productController.productListSearch[index].id) {
              value.isLike = productController.productListSearch[index].isLike;
            }
          }
          return;
        }
      }
      productController.productListSearch[index].isLike = !productController.productListSearch[index].isLike;
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void likeCategory(int index) async {
    if (userController.token.value == '') {
      showLogIn();
    } else {
      var responseData = await RemoteService.favorite(userController.token.value, productController.productAllType[index].id);
      if (responseData != null) {
        // productController.productAllType[index].isLike =
        //     !productController.productAllType[index].isLike;
        if (responseData.status == 0) {
          if (!productController.productAllType[index].isLike) {            
            var product = producFavoritetList.firstWhere((x) => x.id == productController.productAllType[index].id, orElse: () => p);
            if (product.id != -1) {
              producFavoritetList.remove(product);
            }
          } else {
            producFavoritetList.add(productController.productAllType[index]);
          }
          for (var value in productController.productList) {
            if (value.id == productController.productAllType[index].id) {
              value.isLike = productController.productAllType[index].isLike;
            }
          }
          return;
        }
      }
      productController.productAllType[index].isLike = !productController.productAllType[index].isLike;
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void likeFavorite(int index) async {
    if (userController.token.value == '') {
      showLogIn();
    } else {
      var responseData = await RemoteService.favorite(userController.token.value, producFavoritetList[index].id);
      if (responseData != null) {
        if (responseData.status == 0) {
          for (var value in productController.productList) {
            if (value.id == producFavoritetList[index].id) {
              value.isLike = !producFavoritetList[index].isLike;
            }
          }
          producFavoritetList.removeAt(index);
          return;
        }
      }
      productController.productListSearch[index].isLike = !productController.productListSearch[index].isLike;
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
