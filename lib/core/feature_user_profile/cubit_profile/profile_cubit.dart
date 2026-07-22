import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_login/data/login_model.dart';
import 'package:scholar/core/feature_login/presentation/LogInView.dart';
import 'package:scholar/core/feature_user_profile/data/log_out_api.dart';
import 'package:scholar/core/feature_user_profile/data/profile_api.dart';
import 'package:scholar/core/feature_user_profile/provider/profile_provider.dart';
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';
import 'package:scholar/helper/global_variable_provide.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:tuple/tuple.dart';

import '../../../main.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>  {
  ProfileCubit() : super(ProfileInitial());

  // updateImageProfile(BuildContext context, String name,
  //     String email, String phone, String profileImage) async {
  //   emit(ProfileLoadingState());
  //   Tuple2<LogInModel, int> response = await ProfileApi.updateProfile(
  //        name, email, phone, profileImage , context);
  //   print("updateImageProfile body ${response.item1}");
  //   print("updateImageProfile status code ${response.item2}");
  //
  //   if (response.item2 == 200)
  //   {
  //     Provider.of<ProfileProvider>(context, listen: false).updateUserObject(response.item1);
  //     Provider.of<ProfileProvider>(context, listen: false).updateImageProfile = false;
  //     showMessage(context,"نجح تحديث الصوره", false);
  //     emit(ProfileImageSuccessEditState(response.item1));
  //   }
  //   else
  //   {
  //     showMessage(context,"فشل تحديث الصوره", true);
  //     emit(ProfileImageUploadFailedState());
  //   }
  // }

 Future<int> updateProfileInfo(BuildContext context, String name,
      String email, String phone, File? profileImage) async {

    emit(ProfileLoadingState());
    Tuple2<LogInModel, int> response = await ProfileApi.updateProfile(
         name, email, phone, profileImage, context);
    print("updateProfileInfo body ${response.item1}");
    print("updateProfileInfo status code ${response.item2}");

    if (response.item2 == 200) {
      // print(
      //     "response.item2 ${response.item1}  ${response.item1.data.phoneVerifiedAt}");

      Provider.of<ProfileProvider>(context, listen: false).updateUserObject(response.item1);
      emit(ProfileSuccessEditState(response.item1));
      showMessage(context," نجح تحديث المعلومات", false);
      // if (response.item1.data.phoneVerifiedAt == null)
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) => Home()), (route) => false);
      // else

      Navigator.pop(context);


    } else {
      showMessage(context,"فشل تحديث المعلومات", true);
      emit(ProfileErrorState());
    }
    return response.item2;
  }

  changePassword(BuildContext context, String oldPassword, String newPassword) async {
    emit(ProfileLoadingState());

    int statusCode =
        await ProfileApi().changePassword(oldPassword, newPassword, context);

    print("statusCode changePassword profile cubit $statusCode");
    if (statusCode == 200) {
      emit(ProfileSuccessChangePasswordState());

      showMessage(context,"تم تغيير كلمة السر بنجاح",false);

      Navigator.pop(context);
    } else {
      emit(ProfileFailedChangePasswordState());
    }
  }

  logOut(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet))  {
      emit(ProfileLoadingState());
      int statusCode = await LogOutApi.logOut(context);

      if (statusCode == 200) {
        emit(ProfileSuccessLogOutState());
        Provider.of<GlobalVariableProvider>(context, listen: false)
          .setSignInValues(false);

        Provider.of<ProfileProvider>(context, listen: false).isLogOut = true;

        Navigator.pop(Provider.of<ProfileProvider>(context, listen: false).context);

        ConfigClass? configClass = Provider.of<GlobalVariableProvider>(context, listen: false).configClass;

        await SharedPreferencesHelper.setConfig(ConfigClass.empty());

        print(
            " Provider.of<GlobalVariableProvider>(context , listen:  false).configClass ${Provider.of<GlobalVariableProvider>(context, listen: false).configClass}");

        Provider.of<GlobalVariableProvider>(context, listen: false).setConfigGlobalValue(ConfigClass.empty());

        Provider.of<ProfileProvider>(context, listen: false)
          ..updateUserObject(LogInModel())
          ..imagePath = "";
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInView()), (route) => false);
        showMessage(context,"نجح تسجيل الخروج",false);
      }
      else {
        emit(ProfileErrorLogOutState());
        showMessage(context,"فشل تسجيل الخروج", true);
      }
    } else {
      showMessage(context,"تحقق من اتصال الإنترنت", true);
    }
  }
}
