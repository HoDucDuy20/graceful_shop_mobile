class Picture {
    Picture({
        required this.id,
        required this.productId,
        required this.pictureValue,
    });

    int id;
    int productId;
    String pictureValue;

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        id: json["id"],
        productId: json["product_id"],
        pictureValue: json["picture_value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "picture_value": pictureValue,
    };
}


class PicturesRate {
    PicturesRate({
        required this.id,
        required this.rateId,
        required this.pictureValue,
    });

    int id;
    int rateId;
    String pictureValue;

    factory PicturesRate.fromJson(Map<String, dynamic> json) => PicturesRate(
        id: json["id"],
        rateId: json["rate_id"],
        pictureValue: json["picture_value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rate_id": rateId,
        "picture_value": pictureValue,
    };
}
