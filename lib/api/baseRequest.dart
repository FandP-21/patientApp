import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class BaseRequest {
  String token = '';
  final String _baseUrl = "https://thc2020.herokuapp.com/";

  BaseRequest() {
    getToken();
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = (prefs.getString('token') ?? '');
    token = _token;
  }

  Future<dynamic> noTokenGet(
      String url, Map<String, dynamic> queryParams) async {
    var responseJson;
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
        _baseUrl + url,
        queryParameters: queryParams,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Content-Type": "application/json",
            }),
      );
      responseJson = response.data;
      return responseJson;
    } on DioError catch (e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
      return e.response;
    }
  }

  Future<dynamic> noTokenPost(String url, body) async {
    var responseJson;
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.post(
        _baseUrl + url,
        data: body,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Content-Type": "application/json",
            }),
      );
      responseJson = response.data;
      return responseJson;
    } on DioError catch (e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
      return e.response.data;
    }
  }

  Future<dynamic> tokenGet(String url, Map<String, dynamic> queryParams) async {
    var responseJson;
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get(
        _baseUrl + url,
        queryParameters: queryParams,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + this.token
          },
        ),
      );
      responseJson = response.data;
      return responseJson;
    } on DioError catch (e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
      return e.response.data;
    }
  }

  Future<dynamic> tokenPost(String url, body) async {
    var responseJson;
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.post(
        _baseUrl + url,
        data: body,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            },
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + this.token
            }),
      );
      responseJson = response.data;
      return responseJson;
    } on DioError catch (e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
      return e.response.data;
    }
  }
}
