import 'dart:convert';

import 'package:graceful_shop/models/picture.dart';
import 'package:graceful_shop/models/user.dart';

List<Rate> rateFromJson(String str) => List<Rate>.from(json.decode(str)['data'].map((x) => Rate.fromJson(x)));

Rate rate2FromJson(String str) => Rate.fromJson(json.decode(str)['data']);

String rateToJson(List<Rate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rate {
    Rate({
        required this.id,
        this.productId,
        this.user,
        this.userId,
        required this.numRate,
        required this.description,
        required this.createdAt,
        required this.picturesRate,
    });

    int id;
    int? productId;
    User? user;
    int? userId;
    double numRate;
    String description;
    String createdAt;
    List<PicturesRate> picturesRate;

    factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        productId: json["product_id"],
        user: User.fromJson(json["user"]),
        userId: json["user_id"],
        numRate: json["num_rate"].toDouble(),
        description: json["description"],
        createdAt:  DateTime.parse(json["created_at"]).toLocal().toString(),
        picturesRate: List<PicturesRate>.from(json["pictures_rate"].map((x) => PicturesRate.fromJson(x))),
    );

    factory Rate.from2Json(Map<String, dynamic> json) => Rate(
        id: json["rate_id"],
        numRate: json["rate_num_rate"].toDouble(),
        description: json["rate_description"],
        createdAt: json["rate_created_at"],
        picturesRate: [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "num_rate": numRate,
        "description": description,
        "created_at": createdAt,
        "pictures_rate": List<dynamic>.from(picturesRate.map((x) => x.toJson())),
    };
}
