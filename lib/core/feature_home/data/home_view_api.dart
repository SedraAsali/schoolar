import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';

import '../../../helper/constant.dart';
import '../../../helper/global_variable_provide.dart';

class HomeViewApi {
  static Future<HomeViewModel> getAllAcademies(BuildContext context) async {
  //  String url = '${Constant.baseUrl}category/getMeal?restaurant_id=${Constant.restaurantId}';
      String url = '${AppAssets.UrlV}academies';
    try {
      print("url $url");
      final configClass = Provider.of<GlobalVariableProvider>(context,listen: false).configClass;
      print("configClass.token ${configClass?.token}");
      print("configClass.userLogin?.token ${configClass?.userLogin?.token}");
      String? token = configClass?.token;
      print("home api token ${token}");
      final headers = AppAssets.getHeader(token);
      print("URL => ${Uri.parse(url)}");
      print("HEADER => ${AppAssets.getHeader(token)}");

      var response = await http.get(Uri.parse(url),
          headers:{
          "authorization": "Bearer $token",
          }).
      timeout(Duration(seconds: 30));
      print("The status into HomeViewApi -> getAllAcademies ->  is :: ${response.statusCode} ");
      print( "The body into HomeViewApi -> getAllAcademies ->  is :: ${response.body} ");
      if (response.statusCode == 200) {
        return homeViewModelFromJson(response.body);
      }
      else
      {
          return   HomeViewModel(status: "no");
      }
    } on TimeoutException catch (e,steak) {
      print("The status into TimeoutException e -> getAllAcademies ->  is :: $e");
      print("The status into TimeoutException steak -> getAllAcademies ->  is :: $steak");
      return HomeViewModel(status: "no");
    } catch (e,steak) {
      print("The status into catching e -> getAllAcademies ->  is :: $e");
      print("The status into catching steak -> getAllAcademies ->  is :: $steak");
      return HomeViewModel(status: "no");
    }
  }

}
