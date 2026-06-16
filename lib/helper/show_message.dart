import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showMessage(
    BuildContext context,
    String msg,
    bool isError,
    ) {
  showToast(
    msg,
    context: context,
    backgroundColor: isError ? Colors.red : Colors.green,
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  );
}