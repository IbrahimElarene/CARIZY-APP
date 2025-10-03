import 'dart:convert';
import 'dart:developer';

import 'package:cartzy_app/core/model/response/category_response.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:http/http.dart' as http;

abstract class HomeApi {
  // fun getCategories
  static Future<List<CategoryResponse>> getCategories() async {
    //  https:// api.escuelajs.co /api/v1/categories/
    Uri url = Uri.https('api.escuelajs.co', '/api/v1/categories/');
    var response = await http.get(url);
    var responseBody = response.body;
    // json
    var json = jsonDecode(responseBody) as List;
    return json.map((category) => CategoryResponse.fromJson(category)).toList();
  }
  static Future<List<ProductResponse>> getProduct()async{
    //https://api.escuelajs.co/api/v1/products/
    Uri url =Uri.https('api.escuelajs.co','/api/v1/products/');
    var response=await http.get(url);
    var responseBody=response.body;
    //json
    var json=jsonDecode(responseBody) as List;
    return json.map((product)=>ProductResponse.fromJson(product)).toList();
  }
  static Future<List<ProductResponse>> getProductOfCategory(String id)async{
    //https://api.escuelajs.co/api/v1/categories/21/products
    Uri url=Uri.https('api.escuelajs.co','/api/v1/categories/$id/products');
    var response=await http.get(url);
    var responseBody=response.body;
    //json
    var json=jsonDecode(responseBody) as List;
    return json.map((product)=>ProductResponse.fromJson(product)).toList();
  }
}
