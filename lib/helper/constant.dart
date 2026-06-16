import 'dart:io';
import 'package:flutter/material.dart';

import 'dart:ui';

final Color darkBlue = const Color(0xFF0B1F3A);
final Color gold = const Color(0xFFD4AF37);

// enum UserRole {
//   USER,
//   MANAGER,
// }

class AppAssets {

  static final String baseUrl = 'http://192.168.1.7:7000/api/v1.0.0/users/';
  // use not localhost ,but ip of computer  win+R --> ipconfig --> ip4
  static const student = 'assets/images/student.svg';

  static const search = 'assets/images/search.svg';

  static const science = 'assets/images/science.svg';

  static Map<String, String> getHeader(dynamic token)  {

    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
    return header;
  }
}




