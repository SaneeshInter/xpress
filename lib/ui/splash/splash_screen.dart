import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/sharedPrefKeys.dart';
import '../../blocs/utility_bloc.dart';
import '../../db/database.dart';
import '../../dbmodel/allowance_category_model.dart';
import '../../dbmodel/allowance_mode.dart';
import '../../model/country_list.dart';
import '../../model/gender_list.dart';
import '../../model/loctions_list.dart';
import '../../model/schedule_categegory_list.dart';
import '../../model/schedule_hospital_list.dart';
import '../../model/user_shifttiming_list.dart';
import '../../model/user_type_list.dart';
import '../../model/visa_type_list.dart';
import '../../ui/dashboard_screen.dart';
import '../../ui/manager_dashboard_screen.dart';
import '../../ui/splash/user_or_manager.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var token;
  Future changeScreen() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    bool isLoggedIn = shdPre.getString(SharedPrefKey.AUTH_TOKEN) != null;
    var loginType = shdPre.getInt(SharedPrefKey.USER_TYPE);
    Future.delayed(Duration.zero, () {
      if (isLoggedIn && loginType != null) {
        if (loginType == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const DashBoard()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ManagerDashBoard()));
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserOrManager()));
        }

      }
    });

  }

  @override
  void initState() {
    super.initState();
    observe();
    getData();

  }

  @override
  void dispose() {
    super.dispose();
    utility_bloc.dispose();
  }

  getData() async {
    if (await isNetworkAvailable()) {
      utility_bloc.fetchUtility();
    } else {
      showInternetNotAvailable();
    }
  }

  void observe() {
    utility_bloc.utilStream.listen((event) {
      debugPrint(event.toString());
      if (null != event.response) {
        if (event.response?.status?.statusCode == 200) {
          var db = Db();
          db.clearDb();
          var countryList = event.response?.data?.countryList;
          if (null != countryList) {
            for (var item in countryList) {
              var obj =
              CountryList(rowId: item.rowId, countryName: item.countryName);
              db.insertCountryList(obj);
            }
          }
          var categroryList = event.response?.data?.scheduleCategoryList;
          if (null != categroryList) {
            for (var item in categroryList) {
              var obj = ScheduleCategoryList(
                  rowId: item.rowId,
                  userType: item.userType,
                  category: item.category);
              db.insertCategegoryList(obj);
            }
          }
          var hospitaist = event.response?.data?.hospitalList;
          if (null != hospitaist) {
            for (var item in hospitaist) {
              var obj = HospitalList(
                  rowId: item.rowId,
                  name: item.name,
                  email: item.email,
                  phone: item.phone,
                  address: item.address,
                  province: item.province,
                  city: item.city,
                  longitude: item.longitude,
                  latitude: item.latitude,
                  photo: item.photo);

              db.inserthospitalList(obj);
            }
          }

          var allowanceCategory = event.response?.data?.allowanceCategoryList;
          if (null != allowanceCategory) {
            for (var item in allowanceCategory) {
              var obj = AllowanceCategoryList(
                rowId: item.rowId,
                category: item.category,
              );
              db.insertAllowanceCategoryList(obj);
            }
          }

          var allowance = event.response?.data?.allowanceList;
          if (null != allowance) {
            for (var item in allowance) {
              var obj = AllowanceList(
                rowId: item.rowId,
                category: item.category,
                allowance: item.allowance,
                amount: item.amount,
                maxAmount: item.maxAmount,
                comment: item.comment,
              );
              db.insertAllowanceList(obj);
            }
          }

          var genderList = event.response?.data?.genderList;
          if (null != genderList) {
            for (var item in genderList) {
              var obj = GenderList(rowId: item.rowId, gender: item.gender);
              db.insertGenderList(obj);
            }
          }

          var loctionsList = event.response?.data?.loctionsList;
          if (null != loctionsList) {
            for (var item in loctionsList) {
              var obj =
              LoctionsList(rowId: item.rowId, location: item.location);
              db.insertLoctionsList(obj);
            }
          }

          var userTypeList = event.response?.data?.userTypeList;
          if (null != userTypeList) {
            for (var item in userTypeList) {
              var obj = UserTypeList(rowId: item.rowId, type: item.type);
              db.insertUserTypeList(obj);
            }
          }

          var visaTypeList = event.response?.data?.visaTypeList;
          if (null != visaTypeList) {
            for (var item in visaTypeList) {
              var obj = VisaTypeList(rowId: item.rowId, type: item.type);
              db.insertVisaTypeList(obj);
            }
          }

          var shiftTimingList = event.response?.data?.shiftTimingList;
          if (null != shiftTimingList) {
            for (var item in shiftTimingList) {
              var obj = ShiftTimingList(
                  rowId: item.rowId,
                  shift: item.shift,
                  startTime: item.startTime,
                  endTime: item.endTime);
              db.insertShiftTimingList(obj);
            }
          }

          changeScreen();
        }
      } else {
        showInternetNotAvailable();
      }
    });
  }

  void showInternetNotAvailable() {
    Navigator.pushNamed(context, '/nw_error').then((_) {
      getData();
    });
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Constants.colors[3],
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/icon/Bg1.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/icon/whitelogo.svg",
            width:  71.5.w,
          ),
        ),
      ),
    );
  }

}
