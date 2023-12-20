import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HTTP {
  static final HTTP _instance = HTTP._internal();
  HTTP._internal() {
    _httpClient = http.Client();
  }

  factory HTTP() => _instance;

  Map<String, String>? _headers;

  late http.Client _httpClient;

  String? token;

  http.Client getHttpClient() {
    return _httpClient;
  }

  void closeClient() {
    _httpClient.close();
  }

  Map<String, String>? getHeadersWeb() {
    _headers = <String, String>{
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
      "Access-Control-Allow-Methods": "GET, POST, OPTIONS"
    };
    return _headers;
  }

  Future<Map<String, String>> getHeaders(bool isAdmin) async {
    if (_headers == null) {
      _headers = {};
      _headers!["content-type"] = "application/json";
      _headers!["Accept"] = "application/json";
      _headers!["Access-Control-Allow-Origin"] = "*";
      _headers!["Access-Control-Allow-Methods"] = "GET,POST,OPTIONS";
      _headers!["Access-Control-Allow-Credentials"] = "true";
      _headers!["Access-Control-Allow-Headers"] =
      "Origin,Content-Type,Authorization";
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // ignore: prefer_collection_literals
    if (sharedPreferences.containsKey('cookie')) {
      var header = sharedPreferences.getString('cookie');
      if (header != null) {
        _headers!["cookie"] = header;
      }
    }
    if (sharedPreferences.containsKey('LOGGED_TOKEN')) {
      var header = sharedPreferences.getString('LOGGED_TOKEN');
      if (header != null) {
        _headers!["Authorization"] = header;
      }
    }

    if (isAdmin) {
      if (sharedPreferences.containsKey('TOKEN')) {
        var header = sharedPreferences.getString('TOKEN');
        if (header != null) {
          _headers!["Authorization"] = header;
        }
      }
    }

    return _headers!;
  }

  Future<bool> hasToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userToken = sharedPreferences.getString("LOGGED_TOKEN");
    if (userToken == null) {
      return false;
    } else {
      // var tk = userToken.split(' ');
      // bool hasExpired = JwtDecoder.isExpired(tk[1]);
      return true;
    }
  }

  Future<dynamic> nonAuthPost(String url, body) async {
    try {
      Map<String, String> headers = await getHeaders(false);
      headers.remove("Authorization");
      return await getHttpClient()
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 50000));
    } catch (e) {
      log("HTTP [POST ERROR] :", error: e);
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

  Future<dynamic> nonAuthPut(String url, body) async {
    try {
      Map<String, String> headers = await getHeaders(false);
      headers.remove("Authorization");
      return await getHttpClient()
          .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 50000));
    } catch (e) {
      // log("HTTP [POST ERROR] :", error: e);
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

  Future<dynamic> post(String url, body ,{bool isAdmin = false}) async {
    try {
      Map<String, String> headers = await getHeaders(isAdmin);
      // log("HTTP::POST", name: url, error: body);
      return await getHttpClient().post(Uri.parse(url), headers: headers, body: jsonEncode(body)).timeout(const Duration(seconds: 50000));
    } catch (e) {
      log("HTTP [POST ERROR] :", error: e);
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

  Future<dynamic> put(String url, body, {bool isAdmin = false}) async {
    try {
      Map<String, String> headers = await getHeaders(isAdmin);
      // log("HTTP::PUT", name: url, error: body);
      return await getHttpClient()
          .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 50000));
    } catch (e) {
      log("HTTP [POST ERROR] :", error: e);
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

  Future<dynamic> delete(String url, body, {bool isAdmin = false}) async {
    try {
      Map<String, String> headers = await getHeaders(isAdmin);
      // log("HTTP::DELETE", name: url, error: body);
      return await getHttpClient()
          .delete(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 50000));
    } catch (e) {
      log("HTTP [POST ERROR] :", error: e);
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

  Future<dynamic> get(String url, {bool isAdmin = false}) async {
    try {
      Map<String, String> headers = await getHeaders(isAdmin);
      // log(
      //   "HTTP::GET",
      //   name: url,
      // );
      return getHttpClient()
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 50000));
    } catch (e) {
      return Future.value(http.Response(
          jsonEncode({"Success": false, "Message": e.toString()}), 400));
    }
  }

//
}
