import 'package:get/get.dart';

class Dimensions {
  //height: 781.1
  //widght: 392.7
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double w250 = screenWidth / 1.57;
  static double w210 = screenWidth / 1.87;
  static double w50 = screenWidth / 7.85;
  static double w40 = screenWidth / 9.82;
  static double w35 = screenWidth / 11.22;
  static double w20 = screenWidth / 19.64;
  static double w7 = screenWidth / 56.1;

  static double h250 = screenWidth / 3.12;
  static double h200 = screenHeight / 3.91;
  static double h50 = screenHeight / 15.62;
  static double h40 = screenHeight / 19.53;
  static double h20 = screenHeight / 39.06;
  static double h12 = screenHeight / 65.1;
  static double h7 = screenHeight / 111.57;

  static double font40 = screenWidth / 9.82;
  static double font20 = screenWidth / 19.64;
  static double font17 = screenWidth / 23.1;
  static double font16 = screenWidth / 24.54;
  static double font15 = screenWidth / 26.18;
}
