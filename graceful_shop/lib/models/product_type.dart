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
