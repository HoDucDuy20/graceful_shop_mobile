import 'package:intl/intl.dart';
import 'dart:math';

// ignore: unnecessary_new
final oCcy = new NumberFormat("#,##0", "vi");

extension Ex on double {
  String toStringAsFixedNoZero(int n) =>            
  double.parse(toStringAsFixed(n)).toString(); 
}

class Format {
  static String numPrice(int num) => ('${oCcy.format(num)} đ');

  static String percentReduction(int price, int discountPrice) => ('${(100 - ((price - discountPrice) / price) * 100).round()}%');

  static String date(String dateTime) {
    if(dateTime.length < 10) {
      return  (dateTime);
    }
    return ('${dateTime.substring(8, 10)}-${dateTime.substring(5, 7)}-${dateTime.substring(0, 4)}');
  }

  static String dateTime(String dateTime) {
    if(dateTime.length < 10) {
      return  (dateTime);
    }
    return ('${dateTime.substring(8, 10)}-${dateTime.substring(5, 7)}-${dateTime.substring(0, 4)} ${dateTime.substring(11, 16)}');
  } 

  static String numRate(double num) => ( num.toStringAsFixedNoZero(1));
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String nameTypePayToKeyTypePay(String name){
  if(name == 'Tiền mặt'){
    return 'tm';
  }else if(name == 'ZaloPay'){
    return 'zp';
  }
  return '';
}
