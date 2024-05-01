import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void ToastMassege(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        fontSize: 18.0,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor:Colors.white,);
  }
}