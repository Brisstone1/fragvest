import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

flushbarWidget(BuildContext context, String message, bool isSuccess) {
  Flushbar(
    message: message,
    duration: Duration(seconds: isSuccess ? 5 : 3),
    backgroundColor: isSuccess == true ? Colors.green : Colors.red,
    flushbarPosition: FlushbarPosition.TOP,
  )..show(context);
}
