import 'dart:convert';

List<Voucher> voucherFromJson(String str) => List<Voucher>.from(json.decode(str)['data'].map((x) => Voucher.fromJson(x)));

// String voucherToJson(List<Voucher> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Voucher {
    Voucher({
        required this.id,
        required this.voucherCode,
        required this.description,
        required this.minTotalPrice,
        required this.discountPrice,
        required this.startDate,
        required this.endDate,
    });

    int id;
    String voucherCode;
    String description;
    int minTotalPrice;
    int discountPrice;
    String startDate;
    String endDate;

    factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"],
        voucherCode: json["voucher_code"],
        description: json["description"],
        minTotalPrice: json["min_total_price"],
        discountPrice: json["discount_price"],
        endDate: json["end_date"],
        startDate: json["start_date"],
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "voucher_code": voucherCode,
    //     "description": description,
    //     "min_total_price": minTotalPrice,
    //     "discount_price": discountPrice,
    //     "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    // };
}
