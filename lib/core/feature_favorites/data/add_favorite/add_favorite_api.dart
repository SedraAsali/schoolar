import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../helper/constant.dart';
import '../../../../helper/global_variable_provide.dart';
import 'add_favorite_model.dart';


class AddFavoriteApi {

  static Future<AddFavoriteModel> addFavoriteApi(
      BuildContext context,
      String academyId,
      String userId,
      ) async {


    String url = "${AppAssets.UrlApi}favorites";


    try {

      print("Add Favorite URL => $url");
      print("Add Favorite academyId => $academyId");
      print("Add Favorite userId => $userId");


      final configClass =
          Provider.of<GlobalVariableProvider>(
              context,
              listen: false
          ).configClass;


      String? token = configClass?.token;


      var response = await http.post(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "academyId": academyId,
          "userId": userId,
        }),
      ).timeout(
        const Duration(seconds: 30),
      );


      print("Add Favorite status => ${response.statusCode}");
      print("Add Favorite body => ${response.body}");


      if (response.statusCode == 201) {

        print("Add Favorite Success");

        return AddFavoriteModel.fromJson(
          jsonDecode(response.body),
        );

      } else {

        print("Add Favorite Failed");

        return AddFavoriteModel(
          message: jsonDecode(response.body)["message"] ?? "حدث خطأ",
          error: jsonDecode(response.body)["error"],
        );

      }


    } on TimeoutException catch(e){

      print("Add Favorite Timeout $e");

      return AddFavoriteModel(
        message: "انتهت مهلة الاتصال",
      );


    } catch(e){

      print("Add Favorite Error $e");

      return AddFavoriteModel(
        message: "حدث خطأ",
      );

    }

  }

}