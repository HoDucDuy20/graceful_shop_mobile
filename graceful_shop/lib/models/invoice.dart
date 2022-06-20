import 'dart:convert';

List<Invoice> invoiceFromJson(String str) => List<Invoice>.from(json.decode(str)['data'].map((x) => Invoice.fromJson(x)));

String invoiceToJson(List<Invoice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoice {
    Invoice({
       required this.id,
       required this.invoiceCode ,
       required this.userId,
       required this.voucherId,
       required this.quantity,
       required this.shipPrice,
       required this.untilPrice,
       required this.status,
       required this.createdAt,
    });

    int id;
    String invoiceCode;  
    int userId;
    int voucherId;
    int quantity;
    dynamic shipPrice;
    int untilPrice;
    int status;
    DateTime createdAt;

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceCode: json["invoice_code "],
        userId: json["user_id"],
        voucherId: json["voucher_id"],
        quantity: json["quantity"],
        shipPrice: json["ship_price"],
        untilPrice: json["until_price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "voucher_id": voucherId,
        "quantity": quantity,
        "ship_price": shipPrice,
        "until_price": untilPrice,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}
