class Like {
    Like({
        required this.productId,
        required this.userId,
    });

    int productId;
    int userId;

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        productId: json["product_id"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "user_id": userId,
    };
}