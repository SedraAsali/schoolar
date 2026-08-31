import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_user_profile/data/data_report/report_model.dart';

import 'package:scholar/helper/global_variable_provide.dart';

import '../../../../helper/constant.dart';

class ReportApi {
  static Future<ReportModel> addReport(
    BuildContext context, {
    required String title,
    required String description,
    required String type,
    required String academyId,
  }) async {
    try {
      // ==========================================
      // 1. جلب Token
      // ==========================================

      final configClass = Provider.of<GlobalVariableProvider>(
        context,
        listen: false,
      ).configClass;

      final String? token = configClass?.token;

      print("Report token => $token");
      print("Report title => $title");
      print("Report description => $description");
      print("Report type => $type");
      print("Report academyId => $academyId");

      // ==========================================
      // 2. URL
      // ==========================================

      final String url = '${AppAssets.UrlApi}reports';

      print("Report URL => $url");

      // ==========================================
      // 3. Body
      // ==========================================

      final body = {
        "title": title,
        "description": description,
        "type": type,
        "academyId": academyId,
      };

      print("Report Body => ${jsonEncode(body)}");

      // ==========================================
      // 4. POST
      // ==========================================

      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
              "authorization": "Bearer $token",
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      print("Report statusCode => ${response.statusCode}");
      print("Report body => ${response.body}");

      // ==========================================
      // 5. SUCCESS 201
      // ==========================================

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final reportModel = ReportModel.fromJson(data);

        reportModel.statusCode = response.statusCode;

        return reportModel;
      }

      // ==========================================
      // 6. ERROR 400
      // ==========================================

      if (response.statusCode == 400) {
        final data = jsonDecode(response.body);

        return ReportModel(
          statusCode: response.statusCode,
          status: data["status"],
          message: data["message"],
          report: null,
        );
      }

      // ==========================================
      // 7. أي Status Code آخر
      // ==========================================

      try {
        final data = jsonDecode(response.body);

        return ReportModel(
          statusCode: response.statusCode,
          status: data["status"],
          message: data["message"] ?? "حدث خطأ",
          report: null,
        );
      } catch (_) {
        return ReportModel(
          statusCode: response.statusCode,
          message: "حدث خطأ في الخادم",
          report: null,
        );
      }
    }
    // ==========================================
    // 8. Timeout
    // ==========================================
    on TimeoutException catch (e) {
      print("Report TimeoutException => $e");

      return ReportModel(statusCode: null, message: "Timeout", report: null);
    }
    // ==========================================
    // 9. No Internet
    // ==========================================
    on SocketException catch (e) {
      print("Report SocketException => $e");

      return ReportModel(
        statusCode: null,
        message: "No Internet",
        report: null,
      );
    }
    // ==========================================
    // 10. Other Error
    // ==========================================
    catch (e) {
      print("Report API Error => $e");

      return ReportModel(statusCode: null, message: e.toString(), report: null);
    }
  }
}
