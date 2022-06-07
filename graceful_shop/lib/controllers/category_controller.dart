import 'package:get/get.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/services/remote_service.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  @override
  void onInit() {
    super.onInit();
    getCategores();
  }

  void getCategores() async {
    var categores = await RemoteService.getCategores();
    if (categores != null) {
      categoryList.value = categores;
    }
  }
}
