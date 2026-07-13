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

    var url = "${AppAssets.baseUrl}logout";

    //
    // Map params;
    //   params={
    //     "mobile_id":AppAssets.deviceId
    //   };

   // print(params);


    ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;

    String? token = configClass?.token;

    Map<String, String> header = AppAssets.getHeader(token);


    try{
      print("urllogout ${url}");
      var response =await http.get(Uri.parse(url)  ,headers: header).
      timeout(const Duration(seconds: 30));

      print("response.statusCode logout ${response.statusCode}");

      print("response.body log out  ${response.body}");

      return response.statusCode;
    } on TimeoutException catch (error){
      print("TimeOut Exception error logout  $error");
      return 2;  //  TimeoutException status
    }
    catch(e,stack){
      print("catching error logout  $e");
      print("STACK: $stack");
      return 0; // catch error status
    }
  }
}


