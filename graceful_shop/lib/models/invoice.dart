import 'dart:convert';

import 'package:graceful_shop/models/voucher.dart';
import 'package:graceful_shop/resources/utils/format.dart';

List<Invoice> invoiceFromJson(String str) => List<Invoice>.from(json.decode(str)['data'].map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
    Invoice({
      required this.id,
      required this.invoiceCode ,
      required this.userId,
      this.voucherId,
      this.voucher,
      required this.quantity,
      required this.shipPrice,
      required this.untilPrice,
      required this.name,
      required this.phone,
      required this.address,
      required this.status,
      this.cancelerId,
      this.reason,
      required this.createdAt,
      this.updatedAt,
      required this.typePay,
    });

    int id;
    String invoiceCode;  
    int userId;
    int? voucherId;
    Voucher? voucher;
    int quantity;
    dynamic shipPrice;
    int untilPrice;
    String name;
    String phone;
    String address;
    int status;
    int? cancelerId;
    String? reason;
    String createdAt;
    String? updatedAt;
    String typePay;

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceCode: json["invoice_code"],
        userId: json["user_id"],
        voucherId: json["voucher_id"],
        voucher: json["voucher"] != null ? Voucher.fromJson(json["voucher"]) : null,
        quantity: json["quantity"],
        shipPrice: json["ship_price"],
        untilPrice: json["until_price"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        status: json["status"],
        cancelerId: json["canceler_id"],
        reason: json["reason"],
        createdAt: DateTime.parse(json["created_at"]).toLocal().toString(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal().toString(),
        typePay: nameTypePayToKeyTypePay(json["type_pay"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "voucher_id": voucherId,
        "quantity": quantity,
        "ship_price": shipPrice,
        "until_price": untilPrice,
        "status": status,
        "created_at": createdAt,
    };
}