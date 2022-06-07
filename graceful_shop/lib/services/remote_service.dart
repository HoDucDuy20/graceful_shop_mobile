import 'dart:convert';

import 'package:graceful_shop/models/category.dart';
import 'package:graceful_shop/models/color_size.dart';
import 'package:graceful_shop/models/product.dart';
import 'package:graceful_shop/models/slide_ads.dart';
import 'package:graceful_shop/services/url.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static var client = http.Client();

  static Future<ProductTotal?> getPopularProducts(int page) async {
    var response = await client.post(productPopular(page),
        body: jsonEncode({
          "num": 6,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }

  static Future<ProductTotal?> getNewProducts(int page) async {
    var response = await client.post(productNew(page),
        body: jsonEncode({
          "num": 6,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return productTotalFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }
  
  static Future<ColorSize?> getColorSize(int id) async {
    var response = await client.get(productById(id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return colorSizeFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Category>?> getCategores() async {
    var response = await client.get(category(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return categoryFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }

  static Future<List<SlideAds>?> getSlideAds() async {
    var response = await client.get(slideShow(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return slideAdsFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }

  static Future<List<Product>?> getSlideAdsDetail(int id) async {
    var response = await client.get(slideShowDetail(id),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },);
    if(response.statusCode == 200){
      var jsonString = response.body;
      return productFromJson(jsonString);
    }else
    {
      print('error: '+ response.statusCode.toString());
      return null;
    }
  }
}