import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';

import 'package:scholar/helper/constant.dart';
import 'package:scholar/helper/global_variable_provide.dart';
import 'package:scholar/helper/loading_dialog.dart';
import 'login_model.dart';

class LogInApi {
  static Future<LogInModel> login(
      BuildContext context, String email, String password) async {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();

    var url = "${AppAssets.baseUrl}login";
    print("1.url ......${url}");
    final params = {
      "email": email,
      "password": password,
      //"token": token
    };
    print("log in params $params");
    try {
      print("hi starting");
      LoadingDialog.showLoadingDialog(context, _keyLoader);
      var response = await http.post(Uri.parse(url)   ,
          body: params, headers: {

            HttpHeaders.acceptHeader: "application/json"
          }).timeout(const Duration(seconds: 30));
      print("LogInApi response.statusCode ${response.statusCode}");
      print("LogInApi response.body ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        ConfigClass configClass = ConfigClass();
        configClass.userLogin = logInModelFromJson(response.body);
        configClass.token = logInModelFromJson(response.body).token;

        Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);

        //  Provider.of<ProfileProvider>(context, listen: false).imagePath =
        //      configClass.userLogin.data.profileImg ?? "";
        //  Provider.of<ProfileProvider>(context,listen: false).isLogOut = false;
        print("LogInApi done!");
        print("LogInApi  response json ${response.body}");
        LogInModel xx = logInModelFromJson(response.body);
        print("LogInApi LogInModel  :: ${xx.user}");
        await SharedPreferencesHelper.setConfig(configClass);
        Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);

        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        return logInModelFromJson(response.body);
      }
      else if (response.statusCode == 404) {
        print("LogInApi fail1!");
        print(" response.statusCode ${response.statusCode}");
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        return LogInModel(statusCode:response.statusCode );
      }    else if (response.statusCode == 401) {
        print("LogInApi fail2!");
        print(" response.statusCode ${response.statusCode}");
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        return LogInModel(statusCode: response.statusCode);
      } else if (response.statusCode == 400) {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        print("LogInApi fail3!");
        print(" response.statusCode ${response.statusCode}");
        return LogInModel(statusCode: response.statusCode);
      } else {
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        print("LogInApi fail4!");
        print("LogInApi response.statusCode ${response.statusCode}");
        return LogInModel(status: "failed");
      }
    } on TimeoutException catch (a) {
      print("LogInApi TimeOut Exception error $a ");

      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      return LogInModel(status: "failed");
    } catch (e,stack ) {

      print("LogInApi catching error ${e}");
      print("STACK: $stack");
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      return LogInModel(status: "failed");
    }
  }
}
