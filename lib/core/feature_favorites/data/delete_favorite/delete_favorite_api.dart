import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../helper/constant.dart';
import '../../../../helper/global_variable_provide.dart';
import '../GetFavoriteApi.dart';
import 'delete_favorite_model.dart';

class DeleteFavoriteApi {

  static Future<DeleteFavoriteModel> deleteFavoriteApi(
      BuildContext context,
      String favoriteId,
      ) async {

    String url = "${AppAssets.UrlApi}favorites/$favoriteId";

    try {

      print("Delete Favorite URL => $url");
      print("Delete Favorite Id => $favoriteId");

      final configClass =
          Provider.of<GlobalVariableProvider>(
            context,
            listen: false,
          ).configClass;

      String? token = configClass?.token;
      String? userId = configClass?.userLogin?.user?.id;

      var response = await http.delete(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ).timeout(
        const Duration(seconds: 30),
      );

      print("Delete Favorite status => ${response.statusCode}");
      print("Delete Favorite body => ${response.body}");

      DeleteFavoriteModel model =
      DeleteFavoriteModel.fromJson(
        jsonDecode(response.body),
      );


      if (response.statusCode == 200) {

        model.status = "success";


        // تحديث SharedPreferences
        if (userId != null) {
          await FavoriteApi.getFavoriteApi(
            context,
            userId,
          );
        }

        return model;

      } else {

        model.status = "fail";

        return model;

      }

    } on TimeoutException {

      return DeleteFavoriteModel(
        status: "fail",
        message: "انتهت مهلة الاتصال",
      );

    } catch (e) {

      print("Delete Favorite Error => $e");

      return DeleteFavoriteModel(
        status: "fail",
        message: "حدث خطأ",
      );

    }

  }

}
