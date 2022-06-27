import 'dart:convert';

import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/rate.dart';

List<RatedProduct> ratedProductFromJson(String str) => List<RatedProduct>.from(json.decode(str)['data'].map((x) => RatedProduct.fromJson(x)));

class RatedProduct {
    RatedProduct({
      required this.product,
      required this.rate,
    });

    Product product;
    Rate rate;

    factory RatedProduct.fromJson(Map<String, dynamic> json) => RatedProduct(
        product: Product.fromJson(json),
        rate: Rate.from2Json(json),
    );
}