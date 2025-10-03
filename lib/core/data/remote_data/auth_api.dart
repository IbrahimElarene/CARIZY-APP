import 'dart:convert';

import 'package:cartzy_app/core/model/request/login_reuest.dart';
import 'package:cartzy_app/core/model/request/register_request.dart';
import 'package:cartzy_app/core/model/response/login_response.dart';
import 'package:cartzy_app/core/model/response/register_response.dart';
import 'package:http/http.dart' as http;
abstract class AuthApi{
  static Future<RegisterResponse> register(RegisterRequset request)async{
    //https://api.escuelajs.co/api/v1/users/
    Uri url=Uri.https('api.escuelajs.co','/api/v1/users/');
    var response=await http.post(url,body: request.toJson());
    var responseBody=response.body;
    var json=jsonDecode(responseBody);
    return RegisterResponse.fromJson(json);
  }
  static Future<LoginResponse> login(LoginRequest request)async{
    //https://api.escuelajs.co/api/v1/auth/login
    Uri url=Uri.https('api.escuelajs.co','/api/v1/auth/login');
    var response=await http.post(url,body: request.toJson());
    var responseBody=response.body;
    var json=jsonDecode(responseBody);
    return LoginResponse.fromJson(json);
  }

}