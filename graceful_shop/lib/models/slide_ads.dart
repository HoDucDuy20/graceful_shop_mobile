import 'dart:convert';

List<SlideAds> slideAdsFromJson(String str) => List<SlideAds>.from(json.decode(str)['data'].map((x) => SlideAds.fromJson(x)));

String slideAdsToJson(List<SlideAds> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlideAds {
    SlideAds({
        required this.id,
        required this.picture,
        required this.description,
    });

    int id;
    String picture;
    String description;

    factory SlideAds.fromJson(Map<String, dynamic> json) => SlideAds(
        id: json["id"],
        picture: json["picture"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "description": description,
    };
}
