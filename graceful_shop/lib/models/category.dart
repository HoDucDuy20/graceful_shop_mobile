import 'dart:convert';

import 'package:graceful_shop/models/product_type.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str)['data'].map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
      required this.id,
      required this.categoryName,
      required this.icon,
      required this.productTypes,
  });

  int id;
  String categoryName;
  String icon;
  List<ProductType> productTypes;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      categoryName: json["category_name"],
      icon: json["icon"],
      productTypes: List<ProductType>.from(json["product_types"].map((x) => ProductType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "category_name": categoryName,
      "icon": icon,
      "product_types": List<dynamic>.from(productTypes.map((x) => x.toJson())),
  };
}