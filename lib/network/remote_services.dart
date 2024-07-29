import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:take_home_challenge/network/secure_http_client.dart';


class RemoteServices {
  static String error = '';

  Future<dynamic> getRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      Response result = await MySecureHttpClient.getClient().get(endPoint, queryParameters: map);
      log('status_code: ${result.statusCode}');
      if (result.statusCode == 200) {
        resJson = json.decode(result.toString());
        return resJson;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.message.toString();
        print('error: $errorMessage');
      }
    }
  }

  Future<dynamic> postRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      dynamic result = await MySecureHttpClient.getClient().post(endPoint, data: map);
      if (result.statusCode == 200 || result.statusCode == 201) {
        resJson = json.decode(result.toString());
        return resJson;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.message.toString();
        print('error: $errorMessage');
      }
    }
  }

  Future<dynamic> deleteRequest(String endPoint, Map<String, dynamic> map) async {
    dynamic resJson;
    try {
      Response result = await MySecureHttpClient.getClient().delete(endPoint, queryParameters: map);
      log('status_code: ${result.statusCode}');
      if (result.statusCode == 200) {
        resJson = json.decode(result.toString());
        return resJson;
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.message.toString();
        print('error: $errorMessage');
      }
    }
  }

}
