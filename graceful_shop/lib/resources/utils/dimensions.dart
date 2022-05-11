import 'package:get/get.dart';

class Dimensions {
  //height: 781.1
  //widght: 392.7
  static double screenHeight = Get.context!.height < Get.context!.width
      ? Get.context!.width
      : Get.context!.height;
  static double screenWidth = Get.context!.width < Get.context!.height
      ? Get.context!.height
      : Get.context!.width;

  static double w250 = screenWidth / 1.57 > 252 ? 252 : screenWidth / 1.57;
  static double w210 = screenWidth / 1.87 > 212 ? 212 : screenWidth / 1.87;
  static double w80 = screenWidth / 4.91 > 82 ? 82 : screenWidth / 4.91;
  static double w50 = screenWidth / 7.85 > 52 ? 52 : screenWidth / 7.85;
  static double w40 = screenWidth / 9.82 > 42 ? 42 : screenWidth / 9.82;
  static double w35 = screenWidth / 11.22 > 37 ? 37 : screenWidth / 11.22;
  static double w30 = screenWidth / 13.09 > 32 ? 32 : screenWidth / 13.09;
  static double w25 = screenWidth / 15.71 > 27 ? 27 : screenWidth / 15.71;
  static double w20 = screenWidth / 19.64 > 22 ? 22 : screenWidth / 19.64;
  static double w15 = screenWidth / 26.18 > 17 ? 17 : screenWidth / 26.18;
  static double w10 = screenWidth / 39.27 > 11 ? 11 : screenWidth / 39.27;
  static double w7 = screenWidth / 56.1 > 9 ? 9 : screenWidth / 56.1;
  static double w5 = screenWidth / 78.54 > 7 ? 7 : screenWidth / 78.54;

  static double h250 = screenHeight / 3.12 > 252 ? 252 : screenHeight / 3.12;
  static double h205 = screenHeight / 3.81 > 207 ? 207 : screenHeight / 3.81;
  static double h200 = screenHeight / 3.91 > 202 ? 202 : screenHeight / 3.91;
  static double h100 = screenHeight / 7.81 > 102 ? 102 : screenHeight / 7.81;
  static double h50 = screenHeight / 15.62 > 52 ? 52 : screenHeight / 15.62;
  static double h40 = screenHeight / 19.53 > 42 ? 42 : screenHeight / 19.53;
  static double h30 = screenHeight / 26.04 > 32 ? 32 : screenHeight / 26.04;
  static double h25 = screenHeight / 31.24 > 27 ? 27 : screenHeight / 31.24;
  static double h20 = screenHeight / 39.06 > 22 ? 22 : screenHeight / 39.06;
  static double h12 = screenHeight / 65.1 > 14 ? 14 : screenHeight / 65.1;
  static double h10 = screenHeight / 78.11 > 12 ? 12 : screenHeight / 78.11;
  static double h7 = screenHeight / 111.57 > 9 ? 9 : screenHeight / 111.57;
  static double h5 = screenHeight / 156.22 > 6 ? 6 : screenHeight / 156.22;

  static double font40 = screenWidth / 9.82 > 42 ? 42 : screenWidth / 9.82;
  static double font35 = screenWidth / 11.22 > 37 ? 37 : screenWidth / 11.22;
  static double font30 = screenWidth / 13.09 > 32 ? 32 : screenWidth / 13.09;
  static double font27 = screenWidth / 14.54 > 29 ? 29 : screenWidth / 14.54;
  static double font25 = screenWidth / 15.71 > 27 ? 27 : screenWidth / 15.71;
  static double font20 = screenWidth / 19.64 > 22 ? 22 : screenWidth / 19.64;
  static double font17 = screenWidth / 23.1 > 19 ? 19 : screenWidth / 23.1;
  static double font16 = screenWidth / 24.54 > 18 ? 18 : screenWidth / 24.54;
  static double font15 = screenWidth / 26.18 > 17 ? 17 : screenWidth / 26.18;
}
