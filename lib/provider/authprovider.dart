import 'dart:io';


import 'package:data_manager_tinga/widget/constant.dart';
import 'package:data_manager_tinga/widget/response.dart';
import 'package:data_manager_tinga/widget/sharedpreferance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class authprovider with ChangeNotifier{

  final String token = UserData?.data?.accessToken ?? ""; // Your Bearer token

  Future<http.Response> loginapi(Map<String, String> bodyData) async {

    String url = "$baseUrl/datamanager/login";
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url), body: bodyData)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    print(response.body);
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> passwordchangeapi(Map<String, String> bodyData) async {
    print(token);
    String url = "$baseUrl/datamanager/updatePassword";
    print(url);
    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    }, body: bodyData)
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );
    print(response.headers);
print(response.body);
    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> logoutapi() async {

    String url = "$baseUrl/datamanager/logout";
    var responseJson;
    final response = await http
        .post(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    })
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
}