import 'package:intl/intl.dart';

// ignore: unnecessary_new
final oCcy = new NumberFormat("#,##0", "vi");

class Format {
  static String numPrice(int num) => (oCcy.format(num) + ' đ');
  static String percentReduction(int price, int discountPrice) => ((100 - ((price - discountPrice) / price) * 100).round().toString() + '%');
  static String dateTime(String dateTime) {
    if(dateTime.length < 10)
      return  (dateTime);
    return (dateTime.substring(8, 10) + '-' + dateTime.substring(5, 7) + '-' + dateTime.substring(0, 4));
  }
}
