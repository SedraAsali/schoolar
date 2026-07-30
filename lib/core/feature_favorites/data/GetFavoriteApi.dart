import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';

import '../../../helper/constant.dart';
import '../../../helper/global_variable_provide.dart';
import 'GetFavoriteModel.dart';

class FavoriteApi {
  static Future<GetFavoriteModel> getFavoriteApi(BuildContext? context,String? userId) async {
    //  String url = '${Constant.baseUrl}category/getMeal?restaurant_id=${Constant.restaurantId}';
    String url = "${AppAssets.UrlApi}favorites/$userId";

    try {
      print("url $url");
      final configClass = Provider.of<GlobalVariableProvider>(context!,listen: false).configClass;
      print("configClass.token ${configClass?.token}");
      print("configClass.userLogin?.token ${configClass?.userLogin?.token}");
      String? token = configClass?.token;
      print("FavoriteApi token ${token}");
      final headers = AppAssets.getHeader(token);
      print("URL => ${Uri.parse(url)}");
      print("HEADER => ${AppAssets.getHeader(token)}");

      var response = await http.get(Uri.parse(url),
          headers:{
            "authorization": "Bearer $token",
          }).
      timeout(Duration(seconds: 30));
      print("The status into FavoriteApi -> getFavorite ->  is :: ${response.statusCode} ");
      print( "The body into FavoriteApi -> getFavorite ->  is :: ${response.body} ");
      if (response.statusCode == 200) {
        GetFavoriteModel model = GetFavoriteModel.fromJson(jsonDecode(response.body));
        print( "The body into FavoriteApi -> model.data ->  is :: ${model.data} ");

        if(model.data != null){
          await SharedPreferencesHelper.setFavorite(model.data!);
        }
        return model;
      }
      else
      {
        return   GetFavoriteModel(status: "fail", message: response.body);
      }
    } on TimeoutException catch (e,steak) {
      print("The status into TimeoutException e -> FavoriteApi ->  is :: $e");
      print("The status into TimeoutException steak -> FavoriteApi ->  is :: $steak");
      return GetFavoriteModel(status: "fail",message: "Timeout");
    } catch (e,steak) {
      print("The status into catching e -> FavoriteApi ->  is :: $e");
      print("The status into catching steak -> FavoriteApi ->  is :: $steak");
      return GetFavoriteModel(status: "fail",message: e.toString());
    }
  }

}
