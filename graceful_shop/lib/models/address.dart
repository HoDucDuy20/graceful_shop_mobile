import 'dart:convert';

List<Address> addressFromJson(String str) => List<Address>.from(json.decode(str)['data'].map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
    Address({
        required this.id,
        required this.name,
        required this.address,
        required this.phoneNumber,
        required this.isDefault,
    });

    int id;
    String name;
    String address;
    String phoneNumber;
    bool isDefault;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        isDefault: json["is_default"] == 0 ? false : true,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone_number": phoneNumber,
        "is_default": isDefault,
    };
}
