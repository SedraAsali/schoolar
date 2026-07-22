import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
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


  static Future<Tuple2<LogInModel, int>> updateProfile(
      String name,
      String email,
      String phone,
      File? profileImage,
      BuildContext context,
      ) async {
    var url = "${AppAssets.baseUrl}updateMeAndUpload";

    ConfigClass? configClass =
        Provider.of<GlobalVariableProvider>(context, listen: false).configClass;

    String? token = configClass?.token;
    print("old token update profile ${configClass?.token }");
    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse(url),
    );

    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.acceptHeader: "application/json",
    });

    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["phone"] = phone;

    if (profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "photo",
          profileImage.path,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }

    try {
      var response =
      await request.send().timeout(const Duration(seconds: 30));

      final body = await response.stream.bytesToString();

      print("updateProfile statusCode ${response.statusCode}");
      print("updateProfile body $body");

      if (response.statusCode == 200) {
              ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;

              print ("configClass.userLogin update profile before ${configClass?.userLogin}");

              configClass?.userLogin = logInModelFromJson(body);

              configClass?.userLogin?.token= token;

              configClass?.token =token;

              print("new token update profile ${configClass?.token }");
              await SharedPreferencesHelper.setConfig(configClass!);

              print ("configClass.userLogin update profile after ${configClass.userLogin}");

              Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
        // LogInModel loginModel = logInModelFromJson(body);
        //
        // configClass?.userLogin = loginModel;
        // configClass?.token = loginModel.token;
        // configClass?.userLogin?.token = loginModel.token;
        //
        // await SharedPreferencesHelper.setConfig(configClass!);
        //
        // Provider.of<GlobalVariableProvider>(
        //   context,
        //   listen: false,
        // ).setConfigGlobalValue(configClass)
        return Tuple2(logInModelFromJson(body), response.statusCode);
      } else {
        return Tuple2(LogInModel(status: "error"), response.statusCode);
      }
    } on TimeoutException catch (e,stack){
           print("update profile TimeOut Exception error $e ");
           print("update profile TimeOut Exception stack $stack ");
      return Tuple2(LogInModel(status: "timeout"), 1);
    } catch (e, stack) {
          print("update profile catching error ${e}");
          print("update profile STACK: $stack");
      return Tuple2(LogInModel(status: "catch"), 0);
    }
  }

  // static Future<Tuple2<LogInModel, int>> updateProfile(
  //    // int userId,
  //     String name,
  //     String email,
  //     String phone,
  //     String profileImage,BuildContext context) async {
  //
  //   var url =  "${AppAssets.baseUrl}updateMeAndUpload";
  //
  //   print(url);
  //
  //   Map params;
  //   params = {
  //   //  "user_id": userId.toString(),
  //     "name": name,
  //     "email": email,
  //     "phone": phone,
  //     "photo": profileImage,
  //   };
  //
  //   print(params);
  //
  //   ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;
  //
  //   String? token = configClass?.token;
  //
  //   print("old token update profile $token");
  //
  //   Map<String, String> header = await AppAssets.getHeader(token);
  //
  //   try {
  //     var response = await http
  //         .patch(Uri.parse(url), body: json.encode(params), headers: header)
  //         .timeout(const Duration(seconds: 30));
  //
  //     print("response.statusCode update profile ${response.statusCode}");
  //
  //     print("logInModelFromJson(response.body) update profile ${logInModelFromJson(response.body)}");
  //
  //     if (response.statusCode == 200) {
  //
  //       ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context , listen:  false).configClass;
  //
  //       print ("configClass.userLogin update profile before ${configClass?.userLogin}");
  //
  //       configClass?.userLogin = logInModelFromJson(response.body);
  //
  //       configClass?.userLogin?.token= logInModelFromJson(response.body).token;;
  //
  //       configClass?.token = logInModelFromJson(response.body).token;
  //
  //       print("old token update profile ${configClass?.token }");
  //       await SharedPreferencesHelper.setConfig(configClass!);
  //
  //       print ("configClass.userLogin update profile after ${configClass.userLogin}");
  //
  //       Provider.of<GlobalVariableProvider>(context , listen:  false).setConfigGlobalValue(configClass);
  //
  //
  //       return Tuple2(logInModelFromJson(response.body), response.statusCode);
  //     } else {
  //
  //       return Tuple2(LogInModel(status: "error"), 1); //  TimeoutException status
  //     }
  //   } on TimeoutException catch (e,stack) {
  //     print("update profile TimeOut Exception error $e ");
  //     print("update profile TimeOut Exception stack $stack ");
  //     return Tuple2(LogInModel(status: "timeout"), 1); //  TimeoutException status
  //   } catch (e,stack) {
  //     print("update profile catching error ${e}");
  //     print("update profile STACK: $stack");
  //     return Tuple2(LogInModel(status: "catch"), 0); // catch error status
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
        Provider.of<ProfileProvider>(context, listen: false).imagePath =
            configClass.userLogin?.user?.photo ?? "";
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
