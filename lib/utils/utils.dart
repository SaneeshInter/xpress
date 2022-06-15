import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../ui/Widgets/booking_alert_box.dart';
import '../ui/widgets/action_alert_dialoge.dart';
import '../ui/widgets/add_time_sheet_alert_box.dart';
import '../ui/widgets/login_invalid_alert.dart';

void showMessageAndPop(String? message, BuildContext context) {
  Navigator.pop(context);
  Fluttertoast.showToast(msg: '$message');
}

double screenHeight(context, {required double dividedBy}) {
  getPercentage(context);
  return MediaQuery.of(context).size.height / dividedBy;
}

double commonButtonHeight(context) {
  return 5.5.h;
}

double screenWidth(context, {required double dividedBy}) {
  return MediaQuery.of(context).size.width / dividedBy;
}

void push(context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

double getPercentage(context) {
  var height = MediaQuery.of(context).size.height;

  if (height > 1024) {
    return 10.h;
  } else {
    return 20.h;
  }
}

void pop(context) {
  Navigator.pop(context);
}

String formatDate(DateTime now) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  return formatted;
}

void showBookingAlert(
  context, {
  required String date,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        // Navigator.of(context).pop(true);
      });
      return Center(
        child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 30),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: BookingAlertBox(
              date: date,
              key: null,
            )),
      );
    },
  );
}

void showAddTimeSheet(
  context, {
  required String date,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.of(context).pop(true);
      });
      return Center(
        child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 30),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: AddTimeSheetAlertBox(
              date: date,
              key: null,
            )),
      );
    },
  );
}

void showAlertDialoge(
  context, {
  required String message,
  required String title,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.of(context).pop(true);
      });
      return Center(
        child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 30),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: LoginAlertBox(
              title: title,
              message: message,
              key: null,
            )),
      );
    },
  );
}

selectDate(BuildContext context, TextEditingController dateController) async {
  print("date");
  final DateTime? newDate = await showDatePicker(
    context: context,
    initialDatePickerMode: DatePickerMode.day,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
    helpText: 'Select a date',
    fieldHintText: "dd-MM-yyyy",
  );

  if (newDate != null) {
    print(newDate);

    var dates = DateFormat('dd-MM-yyyy').format(newDate);
    dateController.text = dates;
  }
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

selectTime(BuildContext context, TextEditingController anycontroller) async {
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
    confirmText: "CONFIRM",
    cancelText: "NOT NOW",
    helpText: "BOOKING TIME",
  );

  if (timeOfDay != null) {
    anycontroller.text = timeOfDay.format(context);
  }
}

Future<int> getDifference(String time1, String time2) async {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  var _date = dateFormat.format(DateTime.now());

  DateTime a = DateTime.parse('$_date $time1:00');
  DateTime b = DateTime.parse('$_date $time2:00');

  print('a $a');
  print('b $a');

  print("${b.difference(a).inHours}");
  print("${b.difference(a).inMinutes}");
  print("${b.difference(a).inSeconds}");

  return b.difference(a).inHours;
}

String getDateString(String date, String format) {
  var dateValue = DateTime.parse(date);
  var dtFormats = DateFormat(format);
  String updatedDt = dtFormats.format(dateValue);
  print("updatedDt");
  print(updatedDt);
  return updatedDt;
}

String convert12hrTo24hr(String date) {
  var dateObj = DateFormat("hh:mm a").parse(date);
  var date24 = DateFormat.Hm().format(dateObj);
  return date24;
}

String convert24hrTo12hr(String time, BuildContext context) {
  if (time.contains("PM") || time.contains("AM")) {
    return time;
  }

  TimeOfDay _startTime = TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
  var time12 = _startTime.format(context);
  return time12;
}

void showActionAlert(
  context, {
  required String tittle,
  required String message,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 2), () {
        // Navigator.of(context).pop(true);
      });
      return Center(
        child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 30),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: ActionAlertBox(tittle: tittle, message: message, positiveText: "DELETE", onPositvieClick: () {}, onNegativeClick: () {})),
      );
    },
  );
}

final _picker = ImagePicker();

Future<dynamic> getImage(ImageSource type) async {
  final pickedFile = await _picker.pickImage(source: type, imageQuality: 15);
  if (pickedFile == null) {
    return null;
  } else if (pickedFile.path.isEmpty) {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.file == null) {
      return null;
    } else {
      return File(response.file!.path);
    }
  } else {
    return File(pickedFile.path);
  }
}

Future<dynamic> getFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf'],
  );

  if (result != null) {
    return File(result.files.single.path!);
  } else {
    return;
  }
}

Future<String?> getDeviceId() async {

  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }

}
// get extension of file
String getExtension(String path) {
  var ext = path.split(".").last;
  return ext;
}
//get extension of url
String getExtensionFromUrl(String url) {
  var ext = url.split(".").last;
  return ext;
}



