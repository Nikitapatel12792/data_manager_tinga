import 'dart:io';

import 'package:data_manager_tinga/widget/constant.dart';
import 'package:data_manager_tinga/widget/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class productprovider with ChangeNotifier{
  final String token = UserData?.data?.accessToken ?? "";
  Future<http.Response> getdataapi() async {
    print(token);
    String url = "$baseUrl/datamanager/getScannedData";
    var responseJson;
    final response = await http
        .get(Uri.parse(url),headers: {
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
  Future<http.Response> storeapi() async {

    String url = "$baseUrl/datamanager/stores";
    var responseJson;
    final response = await http
        .get(Uri.parse(url),headers: {
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
  Future<http.Response> productlistingapi(Map<String, String> bodyData) async {
    String url = "$baseUrl/datamanager/products";
    var responseJson;
    final response = await http
        .post(Uri.parse(url),body: bodyData,headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    }, )
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> productdetailapi(String? did,String? strid) async {
    print(token);
    String url = '$baseUrl/datamanager/productdetail?id=$did&store_id=$strid';
    print(url);

    var responseJson;
    final response = await http
        .get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    }, )
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
  Future<http.Response> searchapi(Map<String, String> bodyData) async {


    String url = "$baseUrl/datamanager/searchproducts";

    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    },body: bodyData )
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> categoryapi() async {
    print(token);

    String url = "$baseUrl/datamanager/categories";

    var responseJson;
    final response = await http
        .get(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    } )
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> subcategoryapi(Map<String, String> bodyData) async {
    print(token);
    String url = "$baseUrl/datamanager/subcategories";
    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    },body: bodyData )
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> subsubcategoryapi(Map<String, String> bodyData) async {

    String url = "$baseUrl/datamanager/subsubcategories";

    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    },body: bodyData )
        .timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        throw const SocketException('Something went wrong');
      },
    );

    responseJson = responses(response);
    return responseJson;
  }
  Future<http.Response> upcupdateapi(Map<String, String> bodyData) async {


    String url = "$baseUrl/datamanager/updateUPC";

    var responseJson;
    final response = await http
        .post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token', // Set the Bearer token in the header
      // Set any other headers if needed
    },body: bodyData )
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
}