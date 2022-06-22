import 'dart:convert';

import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/product.dart';

List<InvoiceDetail> invoiceDetailFromJson(String str) => List<InvoiceDetail>.from(json.decode(str)['data'].map((x) => InvoiceDetail.fromJson(x)));

String invoiceDetailToJson(List<InvoiceDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceDetail {
    InvoiceDetail({
      required this.productId,
      required this.colorId,
      required this.sizeId,
      required this.quantity,
      required this.price,
      required this.totalPrice,
      required this.product,
      required this.color,
      required this.size,
    });

    int productId;
    int colorId;
    int sizeId;
    int quantity;
    int price;
    int totalPrice;
    Product product;
    ProductColor color;
    ProductSize size;

    factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        productId: json["product_id"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["total_price"],
        product: Product.fromJson(json["product"]),
        color: ProductColor.fromJson(json["color"]),
        size: ProductSize.fromJson(json["size"]),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "color_id": colorId,
        "size_id": sizeId,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "product": product.toJson(),
        "color": color.toJson(),
        "size": size.toJson(),
    };
}