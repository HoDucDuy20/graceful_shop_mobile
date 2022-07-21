import 'package:get/get.dart';

class Dimensions {
  //height: 781.1
  //widght: 392.7
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double height = screenHeight < screenWidth ? screenWidth : screenHeight;
  static double width = screenWidth < screenHeight ? screenWidth : screenHeight;

  static double w250 = width / 1.57 > 252 ? 252 : width / 1.57;
  static double w210 = width / 1.87 > 212 ? 212 : width / 1.87;
  static double w100 = width / 3.93 > 102 ? 102 : width / 3.93;
  static double w80 = width / 4.91 > 82 ? 82 : width / 4.91;
  static double w65 = width / 6.04 > 67 ? 67 : width / 6.04;
  static double w50 = width / 7.85 > 52 ? 52 : width / 7.85;
  static double w40 = width / 9.82 > 42 ? 42 : width / 9.82;
  static double w35 = width / 11.22 > 37 ? 37 : width / 11.22;
  static double w30 = width / 13.09 > 32 ? 32 : width / 13.09;
  static double w25 = width / 15.71 > 27 ? 27 : width / 15.71;
  static double w20 = width / 19.64 > 22 ? 22 : width / 19.64;
  static double w15 = width / 26.18 > 17 ? 17 : width / 26.18;
  static double w10 = width / 39.27 > 11 ? 11 : width / 39.27;
  static double w7 = width / 56.1 > 9 ? 9 : width / 56.1;
  static double w5 = width / 78.54 > 7 ? 7 : width / 78.54;

  static double h275 = height / 2.84 > 277 ? 277 : height / 2.84;
  static double h250 = height / 3.12 > 252 ? 252 : height / 3.12;
  static double h205 = height / 3.81 > 207 ? 207 : height / 3.81;
  static double h200 = height / 3.91 > 202 ? 202 : height / 3.91;
  static double h180 = height / 4.34 > 182 ? 182 : height / 4.34;
  static double h150 = height / 5.21 > 152 ? 152 : height / 5.21;
  static double h100 = height / 7.81 > 102 ? 102 : height / 7.81;
  static double h80 = height / 9.76 > 82 ? 82 : height / 9.76;
  static double h65 = height / 12.02 > 67 ? 67 : height / 12.02;
  static double h50 = height / 15.62 > 52 ? 52 : height / 15.62;
  static double h40 = height / 19.53 > 42 ? 42 : height / 19.53;
  static double h30 = height / 26.04 > 32 ? 32 : height / 26.04;
  static double h25 = height / 31.24 > 27 ? 27 : height / 31.24;
  static double h20 = height / 39.06 > 22 ? 22 : height / 39.06;
  static double h12 = height / 65.1 > 14 ? 14 : height / 65.1;
  static double h10 = height / 78.11 > 12 ? 12 : height / 78.11;
  static double h7 = height / 111.57 > 9 ? 9 : height / 111.57;
  static double h5 = height / 156.22 > 6 ? 6 : height / 156.22;
  static double hCard = height / 1.95 > 406 ? 406 : height / 1.95 < 350 ? 350 : height / 1.95;
  static double hCard2 = height / 2.85 > 292 ? 292 : height / 2.85 < 270 ? 270 : height / 2.85;
  static double hLstCategory = height / 7.81 > 104 ? 104 : height / 7.81 < 75 ? 75 : height / 7.81;
  static double hSearch1 = height / 26.04 > 32 ? 32 : height / 26.04 < 27 ? 27 : height / 26.04;
  static double hSearch2 = height / 19.53 > 42 ? 42 : height / 19.53 < 38 ? 38 : height / 19.53;

  static double font40 = width / 9.82 > 42 ? 42 : width / 9.82;
  static double font35 = width / 11.22 > 37 ? 37 : width / 11.22;
  static double font30 = width / 13.09 > 32 ? 32 : width / 13.09;
  static double font27 = width / 14.54 > 29 ? 29 : width / 14.54;
  static double font25 = width / 15.71 > 27 ? 27 : width / 15.71;
  static double font20 = width / 19.64 > 22 ? 22 : width / 19.64;
  static double font17 = width / 23.10 > 19 ? 19 : width / 23.10;
  static double font16 = width / 24.54 > 18 ? 18 : width / 24.54;
  static double font15 = width / 26.18 > 17 ? 17 : width / 26.18;
  static double font14 = width / 28.05 > 16 ? 16 : width / 28.05;
  static double font13 = width / 30.21 > 15 ? 15 : width / 30.21;
  static double font12 = width / 32.73 > 14 ? 14 : width / 32.73;
}
