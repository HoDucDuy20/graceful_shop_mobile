import 'dart:convert';

import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/product.dart';

List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str)['data'].map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
    Cart({
        required this.id,
        required this.productId,
        required this.colorId,
        required this.sizeId,
        required this.quantity,
        required this.product,
        required this.color,
        required this.size,
        this.check = false,
    });

    int id;
    int productId;
    int colorId;
    int sizeId;
    int quantity;
    Product product;
    ProductColor color;
    ProductSize size;
    bool check;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        productId: json["product_id"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
        color: ProductColor.fromJson(json["color"]),
        size: ProductSize.fromJson(json["size"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "product": product.toJson(),
    };
}