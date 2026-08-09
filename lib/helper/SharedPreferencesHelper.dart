import 'dart:convert';

import 'package:scholar/helper/ConfigClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import '../core/feature_favorites/data/GetFavoriteModel.dart';
import '../core/feature_home/data/home_view_model.dart';


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

///Academies
  static Future<void> saveHomeAcademies(
      HomeViewModel homeViewModel,
      ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(
      homeViewModel.toJson(),
    );

    await prefs.setString(
      "HomeAcademies",
      data,
    );

    print("Home Academies Saved");
  }


  static Future<HomeViewModel?> getHomeAcademies() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("HomeAcademies");

    print("Home Academies From Cache => $data");

    if (data == null) {
      return null;
    }

    return HomeViewModel.fromJson(
      jsonDecode(data),
    );
  }

  ///Favorite
  static Future<void> setFavorite(List<Favorite> value) async {
    final prefs = await SharedPreferences.getInstance();

    String data = jsonEncode(
      value.map((e) => e.toJson()).toList(),
    );

    await prefs.setString("Favorite", data);

    print('setFavorite $data');
  }


  static Future<List<Favorite>> getFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("Favorite");

    print('getFavorite $data');

    if (data == null) {
      return [];
    }

    List jsonList = jsonDecode(data);

    return jsonList
        .map((e) => Favorite.fromJson(e))
        .toList();
  }

}