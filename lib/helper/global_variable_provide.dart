import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/helper/ConfigClass.dart';


class GlobalVariableProvider extends ChangeNotifier {

  bool signInDone=false;
  late ConfigClass configClass;





  String? get token => configClass.token;

 // String get tokenFirebase => configClass.firebaseToken;


  setConfigGlobalValue(ConfigClass values){
    configClass=values;
    notifyListeners();
  }

  setSignInValues(bool values) {
    this.signInDone = values;
    notifyListeners();
  }


  setToken(String token)
  {
    configClass.token = token;
    notifyListeners();
  }

  // setTokenFirebase(String tokenFirebase)
  // {
  //   configClass.token = tokenFirebase;
  //   notifyListeners();
  // }

  setUserObject (LogInModel userModel){
    configClass.userLogin = userModel;
    notifyListeners();
  }
}
