import 'package:get/get.dart';
import 'package:graceful_shop/controllers/cart_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/models/Payment.dart';
import 'package:graceful_shop/models/address.dart';
import 'package:graceful_shop/models/invoice.dart';
import 'package:graceful_shop/models/invoice_detail.dart';
import 'package:graceful_shop/resources/widgets/show_dialog.dart';
import 'package:graceful_shop/screens/invoice/invoice_tab.dart';
import 'package:graceful_shop/screens/invoice_detail/invoice_detail.dart';
import 'package:graceful_shop/services/remote_service.dart';

class InvoiceController extends GetxController {
  UserController userController = Get.find<UserController>();
  CartController cartController = Get.find<CartController>();
  var cancelList = <Invoice>[].obs;
  var waitForConfirmationList = <Invoice>[].obs;
  var confirmedList = <Invoice>[].obs;
  var deliveringList = <Invoice>[].obs;
  var deliveredList = <Invoice>[].obs;
  var invoiceDetailList = <InvoiceDetail>[].obs;
  var totalProduct = 0.obs;
  var totalPrice = 0.obs;
  var isVoucher = false.obs;
  var isLoading = false.obs;
  var paymentIndex = 0.obs;

  List<Payment> payments = [
    Payment(
      icon: 'assets/images/pay-money.png', 
      title: 'PaymentOnDelivery', 
      key: 'tm',
    ),
    Payment(
      icon: 'assets/images/zalo-pay.png', 
      title: 'PaymentViaZaloPay', 
      key: 'zp',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  static void back() {
    Get.back();
  }

  void showInvoice() {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    getInvoice();
    Get.to(() => const InvoiceTab());
  }

  
  void showInvoiceDetail(Invoice invoice) {
    getInvoiceDetail(invoice);
    Get.to(() => InvoiceDetailScreen(invoice: invoice));
  }

  void addInvoice(List<int> lstCartId, int? voucherId, int shipPrice, Address address, String? invoiceCode, String? typePay) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }
    isLoading.value = true;
    var responseData = await RemoteService.addInvoice(userController.token.value, lstCartId, voucherId, shipPrice, address, invoiceCode, typePay);
    isLoading.value = false;
    if (responseData != null) {
      cartController.getProductCart();
      if (responseData.status == 0) {
        back();
        // showSuccess('OrderSuccess'.tr);
        // Future.delayed(const Duration(milliseconds: 300), back);
        showSuccess2('OrderSuccess'.tr, ''.tr);
      } else {
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setDefault(){
      cancelList.value = [];
      waitForConfirmationList.value = [];
      confirmedList.value = [];
      deliveringList.value = [];
      deliveredList.value = [];
  }

  void getInvoice() async {
    isLoading.value = true;
    setDefault();
    var invoices = await RemoteService.listInvoice(userController.token.value);
    if (invoices != null) {
      for (var value in invoices) {
        switch (value.status) {
          case 0:
            cancelList.add(value);
            break;
          case 1:
            waitForConfirmationList.add(value);
            break;
          case 2:
            confirmedList.add(value);
            break;
          case 3:
            deliveringList.add(value);
            break;
          case 4:
            deliveredList.add(value);
            break;
        }
      }
    }else{
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  void cancelInvoice(int invoiceId, String reason) async {
    if (userController.token.value == '') {
      showLogIn();
      return;
    }

    isLoading.value = true;

    var responseData = await RemoteService.cancelInvoice(userController.token.value, invoiceId, reason);

    if (responseData != null) {
      if (responseData.status != 0) {
        Get.snackbar(
          'FailedAction'.tr,
          responseData.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }else{
        getInvoice();
        back();
        back();
        // showSuccess('CancelOrderSuccess'.tr);
        // Future.delayed(const Duration(milliseconds: 300), back);
        showSuccess2('CancelOrderSuccess'.tr, ''.tr);
      }
    } else {
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
  }

  void getInvoiceDetail(Invoice invoice) async {
    isLoading.value = true;
    invoiceDetailList.value = [];
    var invoiceDetail = await RemoteService.invoiceDetail(userController.token.value, invoice.id);
    if (invoiceDetail != null) {
      for (var value in invoiceDetail) {
        totalProduct.value += value.quantity;
        totalPrice.value += value.totalPrice;
      }
      invoiceDetailList.value = invoiceDetail;
    }else{
      Get.snackbar(
        'FailedAction'.tr,
        'AnErrorOccurred'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }
}
