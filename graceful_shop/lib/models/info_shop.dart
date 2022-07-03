import 'dart:convert';

InfoShop infoShopFromJson(String str) => InfoShop.fromJson(json.decode(str)['data']);

class InfoShop {
    InfoShop({
        required this.address,
        required this.addressMap,
        required this.phone,
        required this.messManager,
        required this.messChat,
        required this.pageFb,
    });

    String address;
    String addressMap;
    String phone;
    String messManager;
    String messChat;
    String pageFb;

    factory InfoShop.fromJson(Map<String, dynamic> json) => InfoShop(
        address: json["address"]??'',
        addressMap: json["address_map"]??'',
        phone: json["phone"]??'',
        messManager: json["mess_manager"]??'',
        messChat: json["mess_chat"]??'',
        pageFb: json["page_fb"]??'',
    );
}