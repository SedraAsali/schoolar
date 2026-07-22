import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:restorant/View/user_profile/card_profile_model.dart';
// import 'package:restorant/View/user_profile/change_password.dart';
// import 'package:restorant/View/user_profile/saved_card/saved_cards.dart';
//
// import 'package:restorant/Widget/dialogs.dart';
// import 'package:restorant/api/upload_image_api.dart';
// import 'package:restorant/model/photo-model.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/core/feature_user_profile/data/upload_image_api.dart';
import 'package:scholar/helper/show_message.dart';

import '../presentation/editProfile_form.dart';

class ProfileProvider extends ChangeNotifier {

 // List<CardProfile> _cardsInfo;

  late List<TextEditingController> _editProfileControllers , _editPasswordControllers;

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


 // List<CardProfile> get cardsInfo => _cardsInfo;

  List<TextEditingController> get editProfileControllers =>
      _editProfileControllers;

  List<TextEditingController> get editPasswordControllers =>
      _editPasswordControllers;

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

  initEditProfileBottomSheet() {
    _editProfileControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
  }

  initChangePasswordBottomSheet() {
    _editPasswordControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];

    _isLookPassword = List.filled(3, false);
  }





  /// Functions
  ///

  getImagePicker(ImageSourcePicker imageSourcePicker,
      BuildContext context) async {

    final XFile? pickedFile = await picker.pickImage(
      source: imageSourcePicker == ImageSourcePicker.Camera
          ? ImageSource.camera
          : ImageSource.gallery,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      showMessage(context, "لم يتم تحديد صورة", false);
    }

    print("getImagePicker _image $_image ");
    notifyListeners();
  }

  uploadImage(BuildContext context) async {
    _isUploadingImage = true ;

    UploadImageModel uploadImageApi = UploadImageModel();

    await uploadImageApi.uploadImageProfile(_image,context, imageType: "profile")
        .then((response) {
          print("uploadImage profile provider response is $response ${response == "0"}");
          if(response != "0" && response != "1" )
            {
              response.stream.transform(utf8.decoder).listen((value) async {
              print("value::: $value");

            //  PhotosModel updateImage = photosModelFromJson(value);

            //  print("path::: ${updateImage.data}");
              //
              // if (updateImage.status == "OK")
              // {
              //   _image = null;
              //   _imagePath = updateImage.data;
              //   _isUploadingImage =false;
              //   BlocProvider.of<ProfileCubit>(context).updateImageProfile(
              //       context,
              //       _userObject.data.id,
              //       _userObject.data.firstName,
              //       _userObject.data.lastName,
              //       _userObject.data.phone,
              //       _imagePath);
              // }
              // else {
              //   _isUploadingImage = false ;
              // }
            });
            }
          else  /// failed upload
            {
              print("failed upload");
              _isFailedUploadImage =true;
              _isUploadingImage = false;
              _updateImageProfile = true; // default is true
            }
    });
    notifyListeners();
  }




  // updateProfileInfo(BuildContext context) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //
  //     if (_editProfileControllers[0].text.trim() == "")
  //       showMessage(getTextLanguage(context.locale, "please enter first name", "Bitte geben Sie den Vornamen ein", "lütfen adı girin", "الرجاء إدخال الاسم الأول"), true);
  //     else if (_editProfileControllers[1].text.trim() == "")
  //       showMessage(getTextLanguage(context.locale, "please enter last name", "Bitte geben Sie den Nachnamen ein", "lütfen soyadınızı girin", "الرجاء إدخال الاسم الأخير"), true);
  //     else if (_editProfileControllers[2].text.trim() == "")
  //       showMessage(getTextLanguage(context.locale, "please enter phone", "Bitte geben Sie das Telefon ein", "lütfen telefon giriniz", "الرجاء إدخال الهاتف"), true);
  //     else
  //       BlocProvider.of<ProfileCubit>(context).updateProfileInfo(
  //           context,
  //           _userObject.data.id,
  //           _editProfileControllers[0].text.trim(),
  //           _editProfileControllers[1].text.trim(),
  //           _countryCode +"-"+ _editProfileControllers[2].text.trim(),
  //           _userObject.data.profileImg);
  //   }
  //   else{
  //     showMessage(getTextLanguage(context.locale, "check internet connection", "Überprüfen Sie die Internetverbindung", "internet bağlantısını kontrol et", "تحقق من اتصال الإنترنت"), true);
  //   }
  //
  // }


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

  @override
  void dispose() {
    _editProfileControllers[0].dispose();
    _editProfileControllers[1].dispose();
    _editProfileControllers[2].dispose();
    _editPasswordControllers[0].dispose();
    _editPasswordControllers[1].dispose();
    _editPasswordControllers[2].dispose();
    super.dispose();
  }

}

enum ImageSourcePicker { Gallery, Camera }
