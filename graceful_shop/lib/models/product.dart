import 'dart:convert';

import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/models/picture.dart';

ProductTotal productTotalFromJson(String str) => ProductTotal.fromJson(jsonDecode(str)['data']);

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str)['data'].map((x) => Product.fromJson(x)));

List<Product> productForUserFromJson(String str) => List<Product>.from(json.decode(str)['data'].map((x) => Product.fromJson(x['product'])));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.productTypeId,
    required this.productBarcode,
    required this.brandId,
    required this.popular,
    required this.numLike,
    required this.numRate,
    required this.description,
    required this.pictures,
    required this.likes,
    this.isLike = false,
    required this.quantityStatus,
  });

  int id;
  String productName;
  int price;
  int productTypeId;
  String productBarcode;
  int brandId;
  int popular;
  int numLike;
  double numRate;
  String description;
  List<Picture> pictures;
  List<Like> likes;
  bool isLike;
  int quantityStatus;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        productTypeId: json["product_type_id"],
        productBarcode: json["product_barcode"],
        brandId: json["brand_id"],
        popular: json["popular"],
        numLike: json["num_like"],
        numRate: json["num_rate"].toDouble(),
        description: json["description"],
        pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        quantityStatus: json["quantity_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "product_type_id": productTypeId,
        "product_barcode": productBarcode,
        "brand_id": brandId,
        "popular": popular,
        "num_like": numLike,
        "num_rate": numRate,
        "description": description,
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        'quantity_status': quantityStatus,
      };
}

class ProductTotal {
  ProductTotal({
    required this.total,
    required this.products,
  });

  int total;
  List<Product> products;

  factory ProductTotal.fromJson(Map<String, dynamic> json) => ProductTotal(total: json["total"], products: List<Product>.from(json["data"].map((x) => Product.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "status": total,
        "pictures": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
