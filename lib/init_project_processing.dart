import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scholar/core/feature_login/presentation/LogInView.dart';
import 'package:scholar/core/presentation/screens/onbording_screen.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';
import 'package:scholar/helper/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/feature_on_boarding/presentation/OnbordingScreenView.dart';
import 'core/presentation/screens/home_screen.dart';
import 'helper/ConfigClass.dart';

/////////////////
class ProcessInitialProject {
  late ConfigClass configClass;

  ProcessInitialProject( BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    disableRotateApp();
  }

  Future initProject() async {
    AppAssets.deviceId = await _getId();

    print("*****initProject  AppAssets.deviceId**** \n ${AppAssets.deviceId} ");

  }

  processGoto(BuildContext context) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    await getConfigPreferences();

    if (sharedPreferences.getBool("isShowedOnBoarding") == null ||
        sharedPreferences.getBool("isShowedOnBoarding") == false) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnboardingScreenView()),
              (route) => false);
    }
    else {

      print("processGoto push  configClass = ${configClass}");

      if (configClass.userLogin== null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogInView()), (route) => false);
      }
      else
      {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      }

    }
  }

  // disable rotation
  disableRotateApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<String> _getId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? "";
    } else {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      print("_getId androidId = ${androidDeviceInfo.id}");
      return androidDeviceInfo.id;
    }
  }

  getConfigPreferences() async {
    configClass = (await SharedPreferencesHelper.getConfig()) ;

    print("***** getConfigPreferences configClass **** \n $configClass ");
  }
}
