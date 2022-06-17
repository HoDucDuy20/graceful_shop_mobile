import 'dart:convert';

import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/rate.dart';
import 'package:graceful_shop/models/response_data.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/models/user.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();
  static int total = 6;

  static Future<ProductTotal?> getPopularProducts(int page) async {
    var response = await client.post(
      uriProductPopular(page),
      body: jsonEncode({
        "num": total,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    } else {
      print('getPopularProducts error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ProductTotal?> getNewProducts(int page) async {
    var response = await client.post(
      uriProductNew(page),
      body: jsonEncode({
        "num": total,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    } else {
      print('getNewProducts error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ColorSize?> getColorSize(int id) async {
    var response = await client.get(
      uriProductById(id),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return colorSizeFromJson(jsonString);
    } else {
      print('getColorSize error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Category>?> getCategores() async {
    var response = await client.get(
      uriCategory(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    } else {
      print('getCategores error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ProductTotal?> getProductsOfType(int typeId, int page) async {
    var response = await client.post(
      uriProductTypeById(typeId, page),
      body: jsonEncode({
        "num": total,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    } else {
      print('getProductsType error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ProductTotal?> getProductsOfAllType(
      int categoryId, int page) async {
    var response = await client.post(
      uriProductTypeById(categoryId, page),
      body: jsonEncode({
        "num": total,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    } else {
      print('getProductsType error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<SlideAds>?> getSlideAds() async {
    var response = await client.get(
      uriSlideShow(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return slideAdsFromJson(jsonString);
    } else {
      print('getSlideAds error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Product>?> getSlideAdsDetail(int id) async {
    var response = await client.get(
      uriSlideShowDetail(id),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      print('getSlideAdsDetail error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> logIn(String phone, String pass) async {
    var response = await client.post(
      uriLogIn(),
      body: jsonEncode({"phone": phone, "password": pass}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('login error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> register(
      String name, String phone, String pass) async {
    var response = await client.post(
      uriRegister(),
      body: jsonEncode({"name": name, "phone": phone, "password": pass}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('register error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> changePass(
      String token, String oldPass, String newPass) async {
    var response = await client.post(
      uriChangePass(),
      body: jsonEncode({"old_pass": oldPass, "new_pass": newPass}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('changePass error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> logOut(String token) async {
    // print(token);
    var response = await client.delete(
      uriLogOut(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('logout error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ProductTotal?> searchProducts(String value, int page) async {
    var response = await client.post(
      uriProductSearch(value, page),
      body: jsonEncode({
        "num": total,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    } else {
      print('getPopularProducts error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> favorite(String token, int product_id) async {
    // print(token);
    var response = await client.post(
      uriFavorite(),
      body: jsonEncode({
        "product_id": product_id,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('like error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Product>?> getProductFavorite(String token) async {
    var response = await client.get(
      uriProductFavorite(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productForUserFromJson(jsonString);
    } else {
      print('getProductFavorite error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<User?> getUserInfo(String token) async {
    var response = await client.get(
      uriUserInfo(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return userFromJson(jsonString);
    } else {
      print('getUserInfo error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> changeAvatar(
      String token, String profileImg) async {
    var request = http.MultipartRequest('POST', uriChangeAvatar());
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(await http.MultipartFile.fromPath('avatar', profileImg));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('changeAvatar error: ' + response.statusCode.toString());
      return null;
    }
  }

  // static Future<ResponseData?> changeInfo(String token, User user) async {
  //   var response = await client.post(
  //     uriChangeInfo(),
  //     body: jsonEncode({
  //       "full_name": user.fullName,
  //       "date_of_birth": user.dateOfBirth,
  //       "sex": user.sex,
  //       "email": user.email,
  //       "address": user.address,
  //     }),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     return responseDataFromJson(jsonString);
  //   } else {
  //     print('register error: ' + response.statusCode.toString());
  //     return null;
  //   }
  // }

  static Future<ResponseData?> changeInfo(
      String token, User user, String? profileImg) async {
    var request = http.MultipartRequest('POST', uriChangeInfo());
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['full_name'] = user.fullName;
    request.fields['date_of_birth'] = user.dateOfBirth;
    request.fields['sex'] = user.sex.toString();
    request.fields['email'] = user.email;
    request.fields['address'] = user.address;
    profileImg != null
        ? request.files
            .add(await http.MultipartFile.fromPath('avatar', profileImg))
        : null;

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('changeInfo error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Rate>?> getRateOfProduct(int product_id) async {
    // print(token);
    var response = await client.post(
      uriRateOfProduct(),
      body: jsonEncode({
        "product_id": product_id,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return rateFromJson(jsonString);
    } else {
      print('getRateOfProduct error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Cart>?> getProductCart(String token) async {
    var response = await client.get(
      uriProductCart(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return cartFromJson(jsonString);
    } else {
      print('getProductCart error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> addCart(String token, int product_id,
      int color_id, int size_id, int quantity) async {
    // print(token);
    var response = await client.post(
      uriAddCart(),
      body: jsonEncode({
        "product_id": product_id,
        "color_id": color_id,
        "size_id": size_id,
        "quantity": quantity,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('addCart error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> updateCart(String token, int product_id,
      int color_id, int size_id, int quantity) async {
    // print(token);
    var response = await client.post(
      uriUpdateCart(),
      body: jsonEncode({
        "product_id": product_id,
        "color_id": color_id,
        "size_id": size_id,
        "quantity": quantity,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('updateCart error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> deleteCart(String token, List<int> lstCartId) async {
    // print(token);
    var response = await client.delete(
      uriDeleteCart(),
      body: jsonEncode({
        "cart_id": lstCartId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('deleteCart error: ' + response.statusCode.toString());
      return null;
    }
  }
}
