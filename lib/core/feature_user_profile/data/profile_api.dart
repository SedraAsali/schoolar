import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';
import 'package:scholar/helper/constant.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/helper/global_variable_provide.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:tuple/tuple.dart';

class ProfileApi {

  // static Future<Tuple2<SignInModel, int>> updateProfile(
  //     int userId,
  //     String firstName,
  //     String lastName,
  //     String phone,
  //     String profileImage,BuildContext context) async {
  //   var url = Constant.baseUrl + "user/update";
  //
  //   Map params;
  //   params = {
  //     "user_id": userId.toString(),
  //     "first_name": firstName,
  //     "last_name": lastName,
  //     "phone": phone,
  //     "profile_img": profileImage,
  //   };
  //
  //   print(params);
  //
  //   ConfigClass configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;
  //
  //   String token = configClass.token;
  //
  //   print(token);
  //   Map<String, String> header = await Constant.getHeader(token);
  //
  //   try {
  //     var response = await http
  //         .put(url, body: json.encode(params), headers: header)
  //         .timeout(const Duration(seconds: 30));
  //
  //     print("response.statusCode ${response.statusCode}");
  //
  //     print("signInModelFromJson(response.body) ${signInModelFromJson(response.body)}");
  //
  //     if (response.statusCode == 235) {
  //
  //       ConfigClass configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;
  //
  //       print ("configClass.userLogin before ${configClass.userLogin}");
  //
  //       configClass.userLogin = signInModelFromJson(response.body);
  //
  //       configClass.userLogin.data.tokenApi = token;
  //
  //       configClass.token = token;
  //       await SharedPreferencesHelper.setConfig(configClass);
  //
  //       print ("configClass.userLogin after ${configClass.userLogin}");
  //
  //       Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
  //
  //
  //       return Tuple2(signInModelFromJson(response.body), response.statusCode);
  //     } else {
  //       return Tuple2(
  //           SignInModel(status: "error"), 1); //  TimeoutException status
  //     }
  //   } on TimeoutException catch (_) {
  //     return Tuple2(
  //         SignInModel(status: "timeout"), 1); //  TimeoutException status
  //   } catch (e) {
  //     print("exception $e");
  //     return Tuple2(SignInModel(status: "catch"), 0); // catch error status
  //   }
  // }

   Future<int> changePassword(String oldPassword, String newPassword , BuildContext context) async {

    var url = "${AppAssets.baseUrl}updateMyPassword";

    print("url change password $url");
    Map params;
    params = {
      "passwordCurrent": oldPassword,
      "password": newPassword,
    };

    print(params);

    ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;

    String? token = configClass?.token;

     print("old token change password $token");
    Map<String, String> header = await AppAssets.getHeader(token);

    try {
      var response = await http
          .patch(Uri.parse(url), body: json.encode(params),
          headers: header
      )
          .timeout(const Duration(seconds: 30));

      print("response.statusCode update profile  ${response.statusCode}");

      print("response.body update profile  ${response.body}");

      if(response.statusCode == 401)
      {
     //   showMessage(context,"كلمة المرور الجديدة هي نفس كلمة المرور القديمة", true);
        showMessage(context,"يرجى تسجيل دخول مرة اخرى", true);
          return response.statusCode;
      }
      else if(response.statusCode == 460)
        {
          showMessage(context, "كلمة المرور غير متطابقة", true);
            return response.statusCode;
        }
      else if(response.statusCode == 500)
      {
        showMessage(context, "قشل تحديث كلمة المرور", true);
        return response.statusCode;
      }
      else if(response.statusCode == 200)
      {
        //showMessage(context, "قشل تحديث كلمة المرور", true);
        ConfigClass configClass = ConfigClass();
        configClass.userLogin = logInModelFromJson(response.body);
        print("configClass.userLogin ${logInModelFromJson(response.body)}");

        configClass.token = logInModelFromJson(response.body).token;
        print("configClass.token update password new ${configClass.token}");
        Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
        await SharedPreferencesHelper.setConfig(configClass);
        //Provider.of<ProfileProvider>(context,listen: false).initialFirstPageProfile(context,  configClass.userLogin!);
        print("PROVIDER TOKEN  update password = ${Provider.of<GlobalVariableProvider>(context, listen: false,).configClass?.token}");

        return response.statusCode;
      }
      else
      return response.statusCode;
    } on TimeoutException catch (error, stack) {
      print("TimeoutException update profile  $error");
      print("TimeoutException update profile  $stack");
      return 1; //  TimeoutException status
    } catch (error,stack) {
      print("catch update profile $error");
      print("catch update profile  $stack");
      return 0; // catch error status
    }
  }

   Future<LogInModel> getProfile({ required BuildContext context}) async {

    var url = "${AppAssets.baseUrl}me";
    final provider = Provider.of<GlobalVariableProvider>(context, listen: false,);
    print("before");
    print(provider);
    print(provider.configClass?.userLogin);
    print(provider.configClass?.token);
    print("after");

    final configClass = Provider.of<GlobalVariableProvider>(context,listen: false).configClass;
    print("configClass.token ${configClass?.token}");
    print("configClass.userLogin?.token ${configClass?.userLogin?.token}");
    String? token = configClass?.token;
    print("token ${token}");

    try {

      var response = await http.get(
          Uri.parse(url),
          headers: AppAssets.getHeader(token)).
          timeout(Duration(seconds: 30));

      print("response.body get profile ${response.body}");

      print("response.statusCode get profile ${response.statusCode}");

      if (response.statusCode == 200) {

        ConfigClass configClass = ConfigClass();

        configClass.userLogin = logInModelFromJson(response.body);

        configClass.userLogin?.token = token;

        configClass.token = token;

        await SharedPreferencesHelper.setConfig(configClass);

        Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
        print("getProfile Provider  GlobalVariableProvider configClass?.userLogin= ${Provider.of<GlobalVariableProvider>(context, listen: false,).configClass?.userLogin}");

        return logInModelFromJson(response.body);

      }  else if (response.statusCode == 401) {

        return LogInModel(status: "notAuth");//Invalid token. Please log in again!
      } else {
        return LogInModel(status: "failed");
      }
    } on TimeoutException catch (error) {
      print("TimeOut Exception error get profile $error");

      return LogInModel(status: "failed");
    }
    on PlatformException catch (e){
      print("Platform Exception error get profile $e");

      return LogInModel(status: "failed");
    } catch (e,stack) {

      print("catching error get profile $e");
      print("STACK: $stack");

      return LogInModel(status: "failed");
    }
  }
}
