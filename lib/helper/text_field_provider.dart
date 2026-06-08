import 'package:flutter/cupertino.dart';

class TextFieldProvider extends ChangeNotifier{
  bool passwordIsLookAtPassword=false;
  bool confirmIsLookAtPassword=false;

  changeBoolState(bool value,int index){
    if (index==1)
      passwordIsLookAtPassword=value;
    else
      confirmIsLookAtPassword=value;
    notifyListeners();

  }


}