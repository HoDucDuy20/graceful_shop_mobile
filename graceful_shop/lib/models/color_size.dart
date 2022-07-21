import 'dart:convert';

ColorSize colorSizeFromJson(String str) => ColorSize.fromJson(json.decode(str)['data']);

String colorSizeToJson(ColorSize data) => json.encode(data.toJson());

class ColorSize {
    ColorSize({
        required this.colors,
        required this.sizes,
        // required this.quantityOfType,
        required this.numOrder,
    });

    List<ProductColor> colors;
    List<ProductSize> sizes;
    // List<QuantityOfType> quantityOfType;
    int numOrder;

    factory ColorSize.fromJson(Map<String, dynamic> json) => ColorSize(
        colors: List<ProductColor>.from(json["colors"].map((x) => ProductColor.fromJson(x))),
        sizes: List<ProductSize>.from(json["sizes"].map((x) => ProductSize.fromJson(x))),
        // quantityOfType: List<QuantityOfType>.from(json["quantityOfType"].map((x) => QuantityOfType.fromJson(x))),
        numOrder: json['numOrder'],
    );

    Map<String, dynamic> toJson() => {
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
        // "quantityOfType": List<dynamic>.from(quantityOfType.map((x) => x.toJson())),
        "numOrder": numOrder,
    };
}

class ProductColor {
    ProductColor({
        required this.id,
        required this.colorName,
        required this.picture,
        required this.productId,
    });

    int id;
    String colorName;
    String picture;
    int productId;

    factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        id: json["id"],
        colorName: json["color_name"],
        picture: json["picture"],
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "color_name": colorName,
        "picture": picture,
        "product_id": productId,
    };
}

class ProductSize {
    ProductSize({
        required this.id,
        required this.sizeName,
        required this.productId,
    });

    int id;
    String sizeName;
    int productId;

    factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        id: json["id"],
        sizeName: json["size_name"],
        productId: json["product_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "size_name": sizeName,
        "product_id": productId,
    };
}

class QuantityOfType {
    QuantityOfType({
        required this.id,
        required this.productId,
        required this.colorId,
        required this.sizeId,
        required this.quantity,
    });

    int id;
    int productId;
    int colorId;
    int sizeId;
    int quantity;

    factory QuantityOfType.fromJson(Map<String, dynamic> json) => QuantityOfType(
        id: json["id"],
        productId: json["product_id"],
        colorId: json["color_id"],
        sizeId: json["size_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "color_id": colorId,
        "size_id": sizeId,
        "quantity": quantity,
    };
}