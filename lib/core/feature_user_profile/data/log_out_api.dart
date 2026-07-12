import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/constant.dart';
import 'package:scholar/helper/global_variable_provide.dart';

class LogOutApi {

  static Future<int> logOut(BuildContext context) async {

    var url = "${AppAssets.baseUrl}auth/logout";


    Map params;
      params={
        "mobile_id":AppAssets.deviceId
      };

    print(params);


    ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;

    String? token = configClass?.token;

    Map<String, String> header = AppAssets.getHeader(token);


    try{
      var response =await http.post(Uri.parse(url)  ,body: json.encode(params),headers: header).
      timeout(const Duration(seconds: 30));

      print("response.statusCode  ${response.statusCode}");

      print("response.body log out  ${response.body}");

      return response.statusCode;
    } on TimeoutException catch (_){
      return 2;  //  TimeoutException status
    }
    catch(e){
      print("exception $e");
      return 0; // catch error status
    }
  }
}


