import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ToastMsg {
  toastMsg({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: Constants.colors[3],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  toastMsg1({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Constants.colors[3],
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
