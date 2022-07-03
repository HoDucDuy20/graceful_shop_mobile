import 'package:get/get.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/voucher.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/voucher/voucher.dart';
import 'package:graceful_shop/services/remote_service.dart';

class VoucherController extends GetxController {
  UserController userController = Get.find<UserController>();
  var voucherList = <Voucher>[].obs;
  var voucherPay = Voucher(id: -1, voucherCode: '', description: '', minTotalPrice: 0, discountPrice: 0, startDate: '', endDate: '').obs;

  @override
  void onInit() {
    super.onInit();
  }

  static void back() {
    Get.back();
  }

  void showVoucher() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    getVoucher();
    Get.to(() => const VoucherScreen());
  }

  void getVoucher() async {
    var vouchers = await RemoteService.listVoucher(userController.token.value);
    if (vouchers != null) {
      voucherList.value = vouchers;
    }
  }

  void addVoucherPay(Voucher voucher) {
    voucherPay.value = voucher;
    Get.back();
  }

}
