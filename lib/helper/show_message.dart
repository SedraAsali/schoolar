import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage(String msg , bool isError) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor:isError ? Colors.blue : Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0);
}