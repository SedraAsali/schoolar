import 'dart:convert';

import 'package:scholar/helper/ConfigClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';


class SharedPreferencesHelper {

  static Future<bool> setConfig(ConfigClass config) async {

    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('config', jsonEncode(config.toJson()));
  }

  static Future<ConfigClass> getConfig() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? jsonConfig = pref.getString('config');
    if (jsonConfig != null) {
      final ConfigClass config = ConfigClass.fromJson(jsonDecode(jsonConfig));
      return config;
    } else {
      return ConfigClass.empty();
    }
  }

  Future<bool?> isShowedOnBoarding() async{
    final SharedPreferences sharedPreferences =await  SharedPreferences.getInstance();
    return sharedPreferences.getBool("isShowedOnBoarding");
  }

  setIsShowedOnBoarding(bool value) async{
    final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setBool("isShowedOnBoarding", value);
  }





}