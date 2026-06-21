import 'dart:convert';

import 'package:scholar/core/feature_login/data/login_model.dart';


ConfigClass configFromJson(String str) => ConfigClass.fromJson(json.decode(str));

String configToJson(ConfigClass data) => json.encode(data.toJson());

class ConfigClass {

  LogInModel? userLogin;
  String? token;
 // String firebaseToken;
 // bool isFirebaseSent;
//  bool isSwitchAllowNotification;


  ConfigClass({this.userLogin, this.token});//,this.firebaseToken,this.isFirebaseSent,this.isSwitchAllowNotification

  factory ConfigClass.fromJson(Map<String, dynamic> json) => new ConfigClass(
    userLogin: json["userLogin"] != null ? LogInModel.fromJson(json["userLogin"]) : null,
    token: json['token'] != null ? json['token'] : null,
   // firebaseToken: json['firebaseToken']!=null?json["firebaseToken"]:null,
  //  isFirebaseSent:json["isFirebaseSent"]!=null?json["isFirebaseSent"]:null,
  //  isSwitchAllowNotification:json["isSwitchAllowNotification"]!=null?json["isSwitchAllowNotification"]:null
  );

  Map<String, dynamic> toJson() => {
    "userLogin": userLogin != null ? userLogin!.toJson() : null,
    'token': token != null ? token : null,
   // 'firebaseToken': firebaseToken != null ? firebaseToken : null,
  //  'isFirebaseSent':isFirebaseSent!=null?isFirebaseSent:null,
   // 'isSwitchAllowNotification':isSwitchAllowNotification!=null?isSwitchAllowNotification:null

  };

  ConfigClass.empty();

  @override
  String toString() {
    return 'ConfigClass{userLogin: $userLogin, token: $token}';
    //, firebaseToken: $firebaseToken, isFirebaseSent: $isFirebaseSent, isSwitchAllowNotification: $isSwitchAllowNotification
  }
}
