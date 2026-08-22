import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../helper/constant.dart';
import '../../../../helper/global_variable_provide.dart';
import 'rating_model.dart';

class RatingApi {
  static Future<RatingModel> addRating(
      BuildContext context,
      String academyId,
      double rating,
      ) async {
    try {
      // ==============================
      // Config
      // ==============================

      final configClass =
          Provider.of<GlobalVariableProvider>(
            context,
            listen: false,
          ).configClass;

      final token = configClass?.token;
      final userId = configClass?.userLogin?.user?.id;

      print("Rating academyId => $academyId");
      print("Rating userId => $userId");
      print("Rating value => $rating");

      // ==============================
      // Request
      // ==============================

      final url = '${AppAssets.UrlV}ratings';
      print("Rating url => $url");

      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode({
          "academyId": academyId,
          "userId": userId,
          "rating": rating,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
      );

      print("Rating statusCode => ${response.statusCode}");
      print("Rating body => ${response.body}");

      // ==============================
      // Success
      // ==============================

      if (response.statusCode == 200) {
        final ratingModel =
        ratingModelFromJson(response.body);

        ratingModel.statusCode =
            response.statusCode;

        return ratingModel;
      }

      // ==============================
      // Backend Error
      // ==============================

      final data = jsonDecode(response.body);

      return RatingModel(
        status: data["status"],
        statusCode: response.statusCode,
        message: data["message"],
      );

    } on TimeoutException {
      print("Rating -> TimeoutException");

      return RatingModel(
        status: "error",
        statusCode: null,
        message: "Timeout",
      );

    } on SocketException {
      print("Rating -> SocketException");

      return RatingModel(
        status: "error",
        statusCode: null,
        message: "No Internet",
      );

    } catch (e, stackTrace) {
      print("Rating -> Error => $e");
      print("Rating -> StackTrace => $stackTrace");

      return RatingModel(
        status: "error",
        statusCode: null,
        message: e.toString(),
      );
    }
  }
}