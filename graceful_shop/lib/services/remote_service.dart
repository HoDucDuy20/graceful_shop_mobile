import 'dart:convert';

import 'package:graceful_shop/models/address.dart';
import 'package:graceful_shop/models/cart.dart';
import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/info_shop.dart';
import 'package:graceful_shop/models/invoice.dart';
import 'package:graceful_shop/models/invoice_detail.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/product_type.dart';
import 'package:graceful_shop/models/rate.dart';
import 'package:graceful_shop/models/rate_product.dart';
import 'package:graceful_shop/models/response_data.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/models/user.dart';
import 'package:graceful_shop/models/voucher.dart';
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

  static Future<ProductTotal?> getSellingProducts(int page) async {
    var response = await client.post(
      uriProductSelling(page),
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

  static Future<ProductTotal?> getProductsOfAllType(int categoryId, int page) async {
    var response = await client.post(
      uriProductCategoryById(categoryId, page),
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

  static Future<ResponseData?> register(String name, String phone, String email, String pass) async {
    var response = await client.post(
      uriRegister(),
      body: jsonEncode({
        "name": name, 
        "phone": phone, 
        "email": email, 
        "password": pass
      }),
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

  static Future<ProductTotal?> searchProducts(String value, int page, int? productTypeId, int? fromPrice, int? toPrice, bool newSort, int priceSort) async {
    var response = await client.post(
      uriProductSearch(value, page),
      body: jsonEncode({
        "num": total,
        "product_type_id": productTypeId,
        "from_price": fromPrice,
        "to_price": toPrice,
        "new_sort": newSort,
        "price_sort": priceSort
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
      print('searchProducts error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<ProductType>?> searchProductType(String value) async {
    var response = await client.get(
      uriProductTypeSearch(value),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productTypeFromJson(jsonString);
    } else {
      print('searchProductType error: ' + response.statusCode.toString());
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

  static Future<ResponseData?> changeAvatar(String token, String profileImg) async {
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

  static Future<ResponseData?> changeInfo(String token, User user, String? profileImg) async {
    var request = http.MultipartRequest('POST', uriChangeInfo());
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['full_name'] = user.fullName;
    request.fields['date_of_birth'] = user.dateOfBirth;
    request.fields['sex'] = user.sex.toString();
    request.fields['email'] = user.email;
    request.fields['address'] = user.address;
    profileImg != null ? request.files.add(await http.MultipartFile.fromPath('avatar', profileImg)) : null;

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

  static Future<ResponseData?> rateProduct(String token, int productId, int numRate, String description, List<String> images) async {
    var request = http.MultipartRequest('POST', uriRateProduct());
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['product_id'] = productId.toString();
    request.fields['num_rate'] = numRate.toString();
    request.fields['description'] = description;

    List<http.MultipartFile> listImage = [];

    for (var img in images) {
      if (img != "") {
        var multipartFile = await http.MultipartFile.fromPath('images[]', img);
        listImage.add(multipartFile);
      }
    }

    request.files.addAll(listImage);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('rateProduct error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> editRateProduct(String token, int rateId, int productId, int numRate, String description, List<String> images) async {
    var request = http.MultipartRequest('POST', uriEditRateProduct());
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['id'] = rateId.toString();
    request.fields['product_id'] = productId.toString();
    request.fields['num_rate'] = numRate.toString();
    request.fields['description'] = description;

    List<http.MultipartFile> listImage = [];

    for (var img in images) {
      if (img != "" && img.contains('graceful_shop/cache/')) {
        var multipartFile = await http.MultipartFile.fromPath('images[]', img);
        listImage.add(multipartFile);
      }
    }
    request.files.addAll(listImage);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('editRateProduct error: ' + response.statusCode.toString());
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

  static Future<ResponseData?> addCart(String token, int productId, int colorId, int sizeId, int quantity) async {
    // print(token);
    var response = await client.post(
      uriAddCart(),
      body: jsonEncode({
        "product_id": productId,
        "color_id": colorId,
        "size_id": sizeId,
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

  static Future<ResponseData?> updateCart(String token, int productId, int colorId, int sizeId, int quantity) async {
    // print(token);
    var response = await client.post(
      uriUpdateCart(),
      body: jsonEncode({
        "product_id": productId,
        "color_id": colorId,
        "size_id": sizeId,
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

  static Future<ResponseData?> addInvoice(String token, List<int> lstCartId, int? voucherId, int shipPrice, Address address, String? invoiceCode, String? typePay) async {
    // print(token);
    var response = await client.post(
      uriAddInvoice(),
      body: jsonEncode({
        "cart_id": lstCartId,
        "voucher_id": voucherId,
        "ship_price": shipPrice,
        "name": address.name, 
        "phone": address.phoneNumber, 
        "address": address.address,
        "invoice_code": invoiceCode,
        "type_pay": typePay,
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
      print('addInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Invoice>?> listInvoice(String token) async {
    var response = await client.get(
      uriInvoiceList(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return invoiceFromJson(jsonString);
    } else {
      print('listInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<InvoiceDetail>?> invoiceDetail(String token, int invoiceId) async {
    var response = await client.get(
      uriInvoiceDetail(invoiceId),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return invoiceDetailFromJson(jsonString);
    } else {
      print('invoiceDetail error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> cancelInvoice(String token, int invoiceId, String reason) async {
    // print(token);
    var response = await client.post(
      uriCancelInvoice(),
      body: jsonEncode({
        "id": invoiceId,
        "reason": reason, 
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
      print('cancelInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Voucher>?> listVoucher(String token) async {
    var response = await client.get(
      uriVoucherList(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return voucherFromJson(jsonString);
    } else {
      print('listVoucher error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Address>?> listAddress(String token) async {
    var response = await client.get(
      uriAddressList(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return addressFromJson(jsonString);
    } else {
      print('listAddress error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> addAddress(String token, Address address) async {
    // print(token);
    var response = await client.post(
      uriAddAddress(),
      body: jsonEncode({
        "name": address.name,
        "address": address.address,
        "phone_number": address.phoneNumber,
        "is_default": address.isDefault
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
      print('addInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> editAddress(String token, Address address) async {
    // print(token);
    var response = await client.post(
      uriEditAddress(),
      body: jsonEncode({
        "id": address.id,
        "name": address.name,
        "address": address.address,
        "phone_number": address.phoneNumber,
        "is_default": address.isDefault
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
      print('addInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> deleteAddress(String token, int idAddress) async {
    // print(token);
    var response = await client.delete(
      uriDeleteAddress(),
      body: jsonEncode({
        "id": idAddress,
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
      print('addInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> sendFeedback(String token, String description) async {
    // print(token);
    var response = await client.post(
      uriSendFeedback(),
      body: jsonEncode({
        "description": description,
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
      print('addInvoice error: ' + response.statusCode.toString());
      return null;
    }
  }
  
  static Future<List<Product>?> productNotYedRated(String token) async {
    var response = await client.get(
      uriProductNotYedRated(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      print('productNotYedRated error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<List<RatedProduct>?> productRated(String token) async {
    var response = await client.get(
      uriProductRated(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return ratedProductFromJson(jsonString);
    } else {
      print('productRated error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<Rate?> ratedDetail(String token, int rateId) async {
    var response = await client.get(
      uriRatedDetail(rateId),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return rate2FromJson(jsonString);
    } else {
      print('ratedDetail error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> requestOtp(String phone) async {
    var response = await client.post(
      uriRequestOtp(),
      body: jsonEncode({
        "phone": phone,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('requestOtp error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<ResponseData?> forgotPass(String phone, String otp, String newPass) async {
    var response = await client.post(
      uriForgotPass(),
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
        "new_pass": newPass,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('forgotPass error: ' + response.statusCode.toString());
      return null;
    }
  }

  static Future<InfoShop?> getInfoShop() async {
    // print(token);
    var response = await client.get(
      uriInfoShop(),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return infoShopFromJson(jsonString);
    } else {
      print('getInfoShop error: ' + response.statusCode.toString());
      return null;
    }
  }

   static Future<ResponseData?> loginWithGoogle(var userGoogle) async {
    var response = await client.post(
      uriLoginWithGoogle(),
      body: jsonEncode({
        "email": userGoogle.email,
        "displayName": userGoogle.displayName,
        "photoUrl": userGoogle.photoUrl
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return responseDataFromJson(jsonString);
    } else {
      print('loginWithGoogle error: ' + response.statusCode.toString());
      return null;
    }
  }
}
