import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/helper/show_message.dart';

import '../presentation/editProfile_form.dart';

class ProfileProvider extends ChangeNotifier {



   File? _image;

  late String _imagePath ;

  final _picker = ImagePicker();

  late List<bool> _isLookPassword;

  late LogInModel _userObject;



  late BuildContext _context;

  bool _isUploadingImage = false ,
      _updateImageProfile = true ,
      _isFailedUploadImage = false ,
      _isLogOut = false;


  /// <Getter>
  ///




  File? get image => _image;

  get picker => _picker;

  List<bool> get isLookPassword => _isLookPassword;

  String get imagePath => _imagePath;

  LogInModel get userObject => _userObject;



  BuildContext get context => _context;

  bool get updateImageProfile => _updateImageProfile;

  bool get isUploadingImage => _isUploadingImage;

  bool get isFailedUploadImage => _isFailedUploadImage;


  get isLogOut => _isLogOut;


  showAnyDialog(BuildContext context, Function callBack,
      {required Widget widgetReturn}) async {
    await showDialog(
        context: context,
        builder: (context) {
          _context = context;
          return widgetReturn;
        }).then((value) {
      callBack();
    });
  }
  /// initial
  ///
  ///

  initialFirstPageProfile(BuildContext context, LogInModel userObj) {
   // _cardsInfo = List();
   // fillCards(context);

    print("*********initialFirstPageProfile*********");
    LogInModel user =LogInModel(
      user: userObj.user,
      status: userObj.status,
      token:userObj.token ,
      statusCode: userObj.statusCode
    );

    print("ProfileProvider user $user ");


    _imagePath = userObj.user?.photo ?? "";
    print("ProfileProvider _imagePath $_imagePath ");
    _userObject = userObj;
    print("ProfileProvider _userObject $_userObject ");

    _image = null;
  }









  /// Functions
  ///





  updateUserObject(LogInModel newInfo) {
    _userObject = newInfo;
    print("updateUserObject _userObject $_userObject");
    notifyListeners();
  }





  // changeLookPassword(bool value, int index) {
  //   _isLookPassword[index] = value;
  //   notifyListeners();
  // }



  set updateImageProfile(bool newValue) {
    _updateImageProfile = newValue ;
    notifyListeners();
  }

  set isFailedUploadImage(bool value) {
    _isFailedUploadImage = value;
    notifyListeners();
  }



  set imagePath (String newImagePtah){
    _imagePath = newImagePtah;
    print("profile provider _imagePath $_imagePath");
    notifyListeners();
  }


  set isLogOut(bool value) {
    _isLogOut = value;
    notifyListeners();
  }

  /// showDialogs
  ///

  // showAnyDialog(BuildContext context, Function callBack,
  //     {@required Widget widgetReturn}) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         _context = context;
  //         return widgetReturn;
  //       }).then((value) {
  //         callBack();
  //   });
  // }

  showAnyModalBottomSheet(context, Function function,
      {required widgetBottomSheet, bool? isDismissible , bool? isScrollControlled}) {

    print("isScrollControlled $isScrollControlled");

    showModalBottomSheet(
        context: context,
        builder: (context) => widgetBottomSheet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
        ),
        isScrollControlled: isScrollControlled ?? true,
        enableDrag: true,
        isDismissible: isDismissible ?? false,
        elevation: 4.0)
        .then((value) {
      function();
    });
  }
  //
  //
  //
  // /// Widget
  // ///
  //
  Widget notch(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), color: Colors.orange),
          width: MediaQuery.of(context).size.width * 0.15,
        ),
      ],
    );
  }
  //
  Widget space({double? height}) {
    return SizedBox(
      height: height ?? 10,
    );
  }
  //
  Widget title(String title, [Color? textColor, double? fontSize]) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: fontSize ?? 16,
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );
  }



}

enum ImageSourcePicker { Gallery, Camera }
