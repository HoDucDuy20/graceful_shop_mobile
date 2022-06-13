import 'dart:convert';

ResponseData responseDataFromJson(String str) => ResponseData.fromJson(json.decode(str));

String responseDataToJson(ResponseData data) => json.encode(data.toJson());

class ResponseData {
    ResponseData({
        required this.status,
        required this.data,
        required this.message,
    });

    int status;
    String data;
    String message;

    factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        status: json["status"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "message": message,
    };
}