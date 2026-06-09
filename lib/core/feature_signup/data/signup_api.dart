import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:restorant/Helper/SharedPreferencesHelper.dart';
import 'package:http/http.dart' as http;
import 'package:scholar/core/feature_login/data/login_model.dart';
//import 'package:restorant/providers/global_variable_provide.dart';
//import 'package:restorant/providers/profile_provider.dart';
import 'package:scholar/helper/constant.dart';
import 'package:scholar/helper/loading_dialog.dart';


class SignUpApi {
  static Future<LogInModel> signup(
      BuildContext context, String name,String email, String password,String role) async {
     final GlobalKey<State> _keyLoader = new GlobalKey<State>();
     print("signup");
    var url = "${AppAssets.baseUrl}signup";
    print("1.url ......${url}");
    final params = {
      "name":name,
      "email": email,
      "password": password,
      "role":role
    };
    print("sign up params $params");
    try {
      print("hi starting");
       LoadingDialog.showLoadingDialog(context, _keyLoader);
      var response = await http.post(Uri.parse(url)   , body: params, headers: {
        HttpHeaders.acceptHeader: "application/json"
      }).timeout(const Duration(seconds: 30));
      print("SignUpApi response.statusCode ${response.statusCode}");
      print("SignUpApi response.body ${response.body}");
      if (response.statusCode == 201) {
        // ConfigClass configClass = ConfigClass();
        //
        // configClass.userLogin=signInModelFromJson(response.body);
        // configClass.token = signInModelFromJson(response.body).data.tokenApi;
        // configClass.firebaseToken = Constant.firebaseToken;
        //
        // Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
        //
        // Provider.of<ProfileProvider>(context , listen:  false).imagePath = configClass.userLogin.data.profileImg ?? "" ;
        //
        // Provider.of<ProfileProvider>(context,listen: false).isLogOut = false;
        //
        // print(" response json ${response.body}");
        // await SharedPreferencesHelper.setConfig(configClass);
        //
        // Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
        print("SignUpApi done!");
        print("SignUpApi  response json ${response.body}");
        LogInModel xx = logInModelFromJson(response.body);
        print("SignUpApi LogInModel  :: ${xx.user}");

         Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        return logInModelFromJson(response.body);
      }
      else if (response.statusCode == 500) {
        print("SignUpApi fail1!");
        print(" response.statusCode ${response.statusCode}");
        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        return LogInModel(statusCode:response.statusCode,status: "Invalid role" );
      }    else if (response.statusCode == 400) {
         Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        print("SignUpApi fail3!");
        print(" response.statusCode ${response.statusCode}");
        return LogInModel(statusCode: response.statusCode,status: "already Exist");
      } else {
           Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
        print("SignUpApi fail4!");
        print("SignUpApi response.statusCode ${response.statusCode}");
        return LogInModel(status: "failed");
      }
    } on TimeoutException catch (_) {
      print("SignUpApi TimeOut Exception error ");

        Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      return LogInModel(status: "failed");
    } catch (e,stack ) {

      print("SignUpApi catching error ${e}");
      print("SignUpApi STACK: $stack");
       Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();

      return LogInModel(status: "failed");
    }
  }
}
