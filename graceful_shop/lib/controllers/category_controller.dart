import 'package:get/get.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/services/remote_service.dart';

class CategoryController extends GetxController {
  ProductController productController = Get.find<ProductController>();
  var categoryList = <Category>[].obs;
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategores();
  }

  void getCategores() async {
    var categores = await RemoteService.getCategores();
    if (categores != null) {
      categoryList.value = categores;
      if(categoryList.isNotEmpty){
        productController.getProductsOfAllType2(categoryList[0].id);
      }
    }
  }
}
