import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/controllers/address_controller.dart';
import 'package:graceful_shop/controllers/cart_controller.dart';
import 'package:graceful_shop/controllers/category_controller.dart';
import 'package:graceful_shop/controllers/product_controller.dart';
import 'package:graceful_shop/controllers/rate_controller.dart';
import 'package:graceful_shop/controllers/slide_ads_controller.dart';
import 'package:graceful_shop/controllers/user_controller.dart';
import 'package:graceful_shop/controllers/voucher_controller.dart';
import 'package:graceful_shop/resources/multiple_language/localization_service.dart';
import 'package:graceful_shop/screens/welcome/welcome.dart';
import 'package:graceful_shop/resources/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/invoice_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // await prefs.setString('lagCode', 'vi');
  LocalizationService.langCodeValue = prefs.getString('lagCode');
  Get.put(UserController());
  Get.put(ProductController());
  Get.put(CategoryController());
  Get.put(SlideAdsController());
  Get.put(CartController());
  Get.put(InvoiceController());
  Get.put(AddressController());
  Get.put(VoucherController());
  Get.put(RateController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graceful Shop',
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        fontFamily: 'Dosis',
        scaffoldBackgroundColor: AppColors.whiteColor,
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      // initialRoute: AppRoute.routeHomeScreen(),
      // initialBinding: AppBinding(),
      // getPages: AppRoute.generateGetPages(),
      home: const Welcome(),
    );
  }
}
