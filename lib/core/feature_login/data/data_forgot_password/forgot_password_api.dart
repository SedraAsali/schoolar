import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholar/helper/constant.dart';
import 'package:scholar/helper/loading_dialog.dart';



import 'forgot_password_model.dart';

class ForgotPasswordApi {
  static Future<ForgotPasswordModel> forgotPassword(
    String email,
  ) async {
   // final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    var url = "${AppAssets.baseUrl}forgotPassword";

    print("ForgotPasswordApi url ...... $url");

    final params = {"email": email};

    print("ForgotPasswordApi params $params");

    try {
      print("ForgotPasswordApi starting");

   //   LoadingDialog.showLoadingDialog(context, _keyLoader);

      var response = await http
          .post(
            Uri.parse(url),
            body: params,
            headers: {HttpHeaders.acceptHeader: "application/json"},
          )
          .timeout(const Duration(seconds: 30));

      print("ForgotPasswordApi response.statusCode ${response.statusCode}");

      print("ForgotPasswordApi response.body ${response.body}");

      // SUCCESS
      if (response.statusCode == 200) {
        print("ForgotPasswordApi success");
        final model = forgotPasswordModelFromJson(response.body);

        model.statusCode = response.statusCode;
       // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        return model;
      }

      // EMAIL NOT FOUND
      else if (response.statusCode == 404) {
        print("ForgotPasswordApi fail 404");

        print("response.statusCode ${response.statusCode}");

       // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        return ForgotPasswordModel(statusCode: response.statusCode);
      }
      // BAD REQUEST
      else if (response.statusCode == 400) {
        print("ForgotPasswordApi fail 400");

        print("response.statusCode ${response.statusCode}");

       // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        return ForgotPasswordModel(statusCode: response.statusCode);
      }
      // OTHER ERRORS
      else {
        print("ForgotPasswordApi fail other");

        print(
          "ForgotPasswordApi response.statusCode "
          "${response.statusCode}",
        );

      //  Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

        return ForgotPasswordModel(
          status: "failed",
          statusCode: response.statusCode,
        );
      }
    }
    on SocketException catch (a) {
      print("ForgotPasswordApi SocketException Exception error $a");

   //   Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
     // rethrow;
     return ForgotPasswordModel(status: "failed");
    }
    // TIMEOUT
    on TimeoutException catch (a) {
      print("ForgotPasswordApi TimeOut Exception error $a");

      // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
    //  rethrow;
      return ForgotPasswordModel(status: "failed");
    }
    // OTHER ERROR
    catch (e, stack) {
      print("ForgotPasswordApi catching error $e");

      print("STACK: $stack");

     // Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      return ForgotPasswordModel(status: "failed");
    }
  }
}
