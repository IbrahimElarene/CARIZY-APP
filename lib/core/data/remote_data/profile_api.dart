import 'dart:convert';

import 'package:cartzy_app/core/model/request/update_user_request.dart';
import 'package:cartzy_app/core/model/response/product_response.dart';
import 'package:cartzy_app/core/model/response/user_response.dart';
import 'package:http/http.dart' as http;

abstract class ProfileApi {
  static Future<UserResponse> getProfileData(String accessToken) async {
    //https://api.escuelajs.co/api/v1/auth/profile
    Uri url = Uri.https('api.escuelajs.co', '/api/v1/auth/profile');
    var response = await http.get(url, headers: {
      'Authorization': "Bearer $accessToken",
    });
    var responseBody = response.body;
    // json
    var json = jsonDecode(responseBody);
    return UserResponse.fromJson(json);
  }
  static Future<UserResponse> updateProfile(UpdateUserRequest request,String id) async {
    //https://api.escuelajs.co/api/v1/users/10
    Uri url = Uri.https('api.escuelajs.co', '/api/v1/users/$id');
    var response = await http.put(url,body:request.toJson());
    var responseBody = response.body;
    // json
    var json = jsonDecode(responseBody);
    return UserResponse.fromJson(json);
  }
}
