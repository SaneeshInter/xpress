import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xpresshealthdev/utils/time_of_day_extensions.dart';

import '../db/database.dart';
import '../main.dart';
import '../ui/Widgets/booking_alert_box.dart';
import '../ui/splash/splash_screen.dart';
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

selectTime(BuildContext context, TextEditingController anycontroller) async {
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
    builder: (BuildContext? context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
    confirmText: "CONFIRM",
    cancelText: "NOT NOW",
    helpText: "BOOKING TIME",
  );

  if (timeOfDay != null) {
    anycontroller.text =
        convert24hrTo12hr("${timeOfDay.hour}:${timeOfDay.minute}");
    print("sefdsff  ${timeOfDay.format12Hour(context)}");
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

// String convert24hrTo12hr(String time, BuildContext context) {
//   if(time.isEmpty) {
//     return "";
//   }
//     print("time: $time ${time.length} ${time.isEmpty}  ${time == ""} ${time ==
//         "null"}");
//     if (time.contains("PM") || time.contains("AM")) {
//       return time;
//     }
//
//     TimeOfDay startTime = TimeOfDay(hour: int.parse(time.split(":")[0]),
//         minute: int.parse(time.split(":")[1]));
//     var time12 = startTime.format(context);
//     return time12;
//
// }

convert24hrTo12hr(String time) {
  if (time.isEmpty) {
    return time;
  }
  try {
    var time24 = DateFormat("HH:mm").parse(time);
    var time12 = DateFormat("hh:mm a").format(time24);
    return time12;
  } catch (e) {
    return time;
  }
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: ActionAlertBox(
                tittle: tittle,
                message: message,
                positiveText: "DELETE",
                onPositvieClick: () {},
                onNegativeClick: () {})),
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
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }
  return null;
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

late DateTime currentBackPressTime;

Future<bool> onWillPopFunction() {
  DateTime now = DateTime.now();
  if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: "Double tap to exit");
    return Future.value(false);
  }
  return Future.value(true);
}

Future<void> logOut(BuildContext context) async {
  var db = Db();
  db.clearDb();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  Future.delayed(Duration.zero, () async {
    // utility_bloc.dispose();

    _finishAccountCreation();
    // Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.pushAndRemoveUntil<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => UserOrManager(),
    //   ),
    //     ModalRoute.withName('/')
    // );
  });
}

void _finishAccountCreation() {
  Navigator.pushAndRemoveUntil(
    MyApp.navigatorKey.currentContext!,
    MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
    ModalRoute.withName('/'),
  );
}

DateTime getDateFromString(String date, String format) {
  try {
    return DateFormat(format).parse(date);
  } catch (e) {
    return DateTime.now();
  }
}

String getStringFromDate(DateTime date, String format) {
  return DateFormat(format).format(date);
}

String checkAndUpdateTimeDiffernce(String dateTo, String dateFrom) {
  if (dateTo.isNotEmpty && dateFrom.isNotEmpty) {
    DateTime date = DateFormat("HH:mm").parse(dateTo);
    DateTime date1 = DateFormat("HH:mm").parse(dateFrom);

    // print("Time :  ${ getDiffrenceBetweenDates(date,date1)}");
    return getDiffrenceBetweenDates(date, date1);
  } else {
    return "";
  }
}

String getDiffrenceBetweenDates(DateTime date, DateTime date2) {
  ("${date.toString()}     ${date2.toString()}");
  DateTime fromDate = date;
  DateTime toDate = date2;
  var diff = date2.difference(date);
  if (diff.inHours < 0) {
    return getHoursAndMinutesToDouble(getHoursFromMinutes((toDate
            .add(const Duration(days: 1))
            .difference(fromDate)
            .inMinutes)))
        .toStringAsFixed(2);
  } else {
    return getHoursAndMinutesToDouble(getHoursFromMinutes(diff.inMinutes))
        .toStringAsFixed(2);
  }
}

int getDiffrenceInSecond(DateTime date, DateTime date2) {
  var diff = date2.difference(date);
  return diff.inSeconds;
}

String getDiffrenceBetweenTwoDates(DateTime date2, DateTime date) {
  var diff = date2.difference(date);
  return getHoursFromMinutes(diff.inMinutes);
}

String getDiffrenceSecondTwoDates(DateTime date2, DateTime date) {
  var diff = date2.difference(date);
  return getHoursAndMinutesFromSecond(diff.inSeconds);
}

String getHoursFromMinutes(int minutes) {
  var hours = (minutes / 60).floor();
  var minutesRemaining = minutes % 60;
  return "${hours.toString().padLeft(2, '0')}:${minutesRemaining.toString().padLeft(2, '0')}";
}

getHoursAndMinutesFromSecond(int seconds) {
  var hours = (seconds / 3600).floor();
  var minutes = (seconds % 3600 / 60).floor();
  var secondsRemaining = seconds % 3600 % 60;
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondsRemaining.toString().padLeft(2, '0')}";
}

double getHoursAndMinutesToDouble(String time) {
  var timeSplit = time.split(":");
  var hours = int.parse(timeSplit[0]);
  var minutes = int.parse(timeSplit[1]);
  var total = hours + (minutes / 60);
  return total;
}

String getHoursAndMinutesFromDouble(double time) {
  var hours = (time).floor();
  var minutes = ((time - hours) * 60).floor();
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
}

launchq(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

Future<bool> launchUrl(Uri url) async {
  if (Platform.isAndroid) {
    return await _launchInAndroid(url);
  } else if (Platform.isIOS) {
    return await _launchInIOS(url);
  } else {
    return false;
  }
}

_launchInAndroid(Uri url) async {
  try {
    return await launch(url.toString(),
        forceSafariVC: false, forceWebView: false);
  } catch (e) {
    return false;
  }
}

_launchInIOS(Uri url) async {
  try {
    return await launch(url.toString(),
        forceSafariVC: false, forceWebView: false);
  } catch (e) {
    return false;
  }
}

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}
