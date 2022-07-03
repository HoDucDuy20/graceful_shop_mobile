import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str)['data']);

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
       required this.id,
       required this.fullName,
       this.dateOfBirth = '',
       this.sex = -1,
       this.sexName = '',
       this.email = '',
       required this.phone,
       this.address = '',
       required this.avatar,
       this.typeLogin = 0,
    });

    int id;
    String fullName;
    String dateOfBirth;
    int sex; 
    String sexName;
    String email;
    String phone;
    String address;
    String avatar;
    int typeLogin;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        dateOfBirth: json["date_of_birth"]??'',
        sex: json["sex"]??-1,
        email: json["email"]??'',
        phone: json["phone"],
        address: json["address"]??'',
        avatar: json["avatar"],
        typeLogin: json["type_login"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "address": address,
        "avatar": avatar,
    };
}
