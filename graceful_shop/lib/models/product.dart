import 'dart:convert';

import 'package:graceful_shop/models/like.dart';
import 'package:graceful_shop/models/picture.dart';

ProductTotal productTotalFromJson(String str) => ProductTotal.fromJson(jsonDecode(str)['data']);

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str)['data'].map((x) => Product.fromJson(x)));

List<Product> productFavoriteFromJson(String str) => List<Product>.from(json.decode(str)['data'].map((x) => Product.fromJson(x['products'])));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.productName,
    required this.stock,
    required this.importPrice,
    required this.price,
    required this.vat,
    required this.discountPrice,
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
  });

  int id;
  String productName;
  int stock;
  int importPrice;
  int price;
  int vat;
  int discountPrice;
  int productTypeId;
  String productBarcode;
  int brandId;
  int popular;
  int numLike;
  int numRate;
  String description;
  List<Picture> pictures;
  List<Like> likes;
  bool isLike;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    stock: json["stock"],
    importPrice: json["import_price"],
    price: json["price"],
    vat: json["vat"],
    discountPrice: json["discount_price"],
    productTypeId: json["product_type_id"],
    productBarcode: json["product_barcode"],
    brandId: json["brand_id"],
    popular: json["popular"],
    numLike: json["num_like"],
    numRate: json["num_rate"],
    description: json["description"],
    pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
    likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "stock": stock,
    "import_price": importPrice,
    "price": price,
    "vat": vat,
    "discount_price": discountPrice,
    "product_type_id": productTypeId,
    "product_barcode": productBarcode,
    "brand_id": brandId,
    "popular": popular,
    "num_like": numLike,
    "num_rate": numRate,
    "description": description,
    "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
    "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
  };
}

class ProductTotal {
  ProductTotal({
    required this.total,
    required this.products,
  });

  int total;
  List<Product> products;

  factory ProductTotal.fromJson(Map<String, dynamic> json) => ProductTotal(
    total: json["total"],
    products:
        List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": total,
    "pictures": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}
