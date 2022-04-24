import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graceful_shop/utils/colors.dart';
import 'package:graceful_shop/welcome/welcome.dart';

void main() {
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
      ),
      home: const Welcome(),
    );
  }
}
