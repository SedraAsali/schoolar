import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_home/data/data_teachers/teachers_model.dart';

import 'package:scholar/helper/global_variable_provide.dart';

import '../../../../helper/constant.dart';

class TeachersApi {
  static Future<TeachersModel> getAllTeachers(
    BuildContext context,
    String academyId,
  ) async {
    try {
      final configClass = Provider.of<GlobalVariableProvider>(
        context,
        listen: false,
      ).configClass;

      String? token = configClass?.token;

      String? role = configClass?.userLogin?.user?.role;

      print("Teachers role => $role");
      print("Teachers token => $token");
      print("Teachers academyId => $academyId");

      // تحديد الرابط حسب Role
      String url;

      if (role == "MANAGER") {
        url = '${AppAssets.UrlV}teachers/mine';
      } else {
        url = '${AppAssets.UrlV}teachers/academy/$academyId';
      }

      print("Teachers URL => $url");

      // Request
      final response = await http
          .get(Uri.parse(url), headers: {"authorization": "Bearer $token"})
          .timeout(const Duration(seconds: 30));

      print("Teachers statusCode => ${response.statusCode}");

      print("Teachers body => ${response.body}");

      // نجاح
      if (response.statusCode == 200) {
        return teachersModelFromJson(response.body);
      }
      // خطأ من Backend
      else {
        final data = jsonDecode(response.body);

        return TeachersModel(
          status: data["status"],
          statusCode: response.statusCode,
          results: data["results"],
          message: data["message"],
          doc: [],
        );
      }
    } on TimeoutException catch (e, stackTrace) {
      print("Teachers TimeoutException e => $e");
      print("Teachers TimeoutException stackTrace => $stackTrace");

      return TeachersModel(
        status: "error",
        statusCode: null,
        message: "Timeout",
        doc: [],
      );
    } on SocketException catch (e, stackTrace) {
      print("Teachers SocketException e => $e");
      print("Teachers SocketException stackTrace => $stackTrace");

      return TeachersModel(
        status: "error",
        statusCode: null,
        message: "No Internet",
        doc: [],
      );
    } catch (e, stackTrace) {
      print("Teachers catch e => $e");
      print("Teachers catch stackTrace => $stackTrace");

      return TeachersModel(
        status: "error",
        statusCode: null,
        message: e.toString(),
        doc: [],
      );
    }
  }
}
