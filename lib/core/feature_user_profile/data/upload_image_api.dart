import 'dart:io';
import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:scholar/helper/ConfigClass.dart';
import 'package:scholar/helper/SharedPreferencesHelper.dart';
import 'package:scholar/helper/show_message.dart';

import '../../../helper/constant.dart';

class UploadImageModel {
  static String? path;

   uploadImageProfile(File? file,BuildContext context, {required String imageType}) async {
    print("image type is $imageType");
     var url =  "${AppAssets.baseUrl}updateMeAndUpload";
    print(url);
     var connectivityResult = await Connectivity().checkConnectivity();
     if (connectivityResult.contains(ConnectivityResult.mobile) ||
         connectivityResult.contains(ConnectivityResult.wifi) ||
         connectivityResult.contains(ConnectivityResult.ethernet))
     {
      try {
        var dir = await path_provider.getTemporaryDirectory();
        final XFile? image = await FlutterImageCompress.compressAndGetFile(
          file!.absolute.path,
          "${dir.absolute.path}/temp.jpg",
          quality: 60,
          minWidth: 640,
          minHeight: 480,
        );
        if(image!=null) {
          file = File(image.path);
        }

        var stream =http.ByteStream(file.openRead());
        print("Hello from upload 3");

        String? token ;
        ConfigClass configClass = await SharedPreferencesHelper.getConfig().then((value) {
          token = value.token!;
          print("value.token ${value.token} ");
          return value;
        });

        var length = await file.length();

        var uri = Uri.parse(url);

        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.acceptHeader : "application/json"
        };

        var request = http.MultipartRequest("PATCH", uri,);
        print("file.path ${file.path}");
        print( "basename(file.path) ${basename(file.path)}");

        var multipartFile =  http.MultipartFile(
          'photo',
          stream,
          length,
          filename: basename(file.path),
          contentType: MediaType('image', 'jpeg'),
        );

        print("Hello from upload $headers");

       // request.fields['image_type'] = imageType;

        request.headers.addAll(headers);

        request.files.add(multipartFile);

        var response = await request.send().timeout(Duration(seconds: 300));

        print("uploadImageProfile response.statusCode is  ${response.statusCode}");

        print("uploadImageProfile the response is $response");
        return response;
      } catch (e,steck) {
        print('uploadImageProfile steck $steck');
        print('uploadImageProfile catch $e');
        return "1";
      }
    } else {
      showMessage(context,"تحقق من اتصال الإنترنت",true);
      return "0";
    }
  }
}
