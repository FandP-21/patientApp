import 'dart:async';
import 'baseRequest.dart';

class Auth extends BaseRequest {
  Future<dynamic> register(data) async {
    final response = await noTokenPost("patient", data);
    return response;
  }

  Future<dynamic> login(data) async {
    final response = await noTokenPost("login", data);
    return response;
  }
}
