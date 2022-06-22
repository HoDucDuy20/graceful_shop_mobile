import 'dart:convert';

List<ProductType> productTypeFromJson(String str) => List<ProductType>.from(json.decode(str)['data'].map((x) => ProductType.fromJson(x)));

String productTypeToJson(List<ProductType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductType {
    ProductType({
        required this.id,
        required this.productTypeName,
        required this.categorieId,
    });

    int id;
    String productTypeName;
    int categorieId;

    factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
        id: json["id"],
        productTypeName: json["product_type_name"],
        categorieId: json["categorie_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_type_name": productTypeName,
        "categorie_id": categorieId,
    };
}
