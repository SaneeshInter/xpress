import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/login_response.dart';
import '../model/user_get_shift_details.dart';
import '../model/user_home_response.dart';

import '../model/accept_job_request.dart';
import '../model/get_available_user_by_date.dart';
import '../model/manager_get_clients.dart';
import '../model/manager_get_time.dart';
import '../model/manager_home_response.dart';
import '../model/manager_response.dart';
import '../model/manager_shift_calendar_respo.dart';
import '../model/manager_timesheet.dart';
import '../model/manager_unit_name.dart';
import '../model/manager_view_request.dart';
import '../model/remove_manager_schedule.dart';
import '../model/shift_list_response.dart';
import '../model/update_profile_questn_respo.dart';
import '../model/user_add_availability.dart';
import '../model/user_availability_btw_date.dart';
import '../model/user_cancel_jobrequest.dart';
import '../model/user_complted_shift.dart';
import '../model/user_documents_response.dart';
import '../model/user_get_response.dart';
import '../model/user_get_timesheet.dart';
import '../model/user_getschedule_by_month_year.dart';
import '../model/user_getschedule_bydate.dart';
import '../model/user_job_request.dart';
import '../model/user_profile_update.dart';
import '../model/user_shift_calender.dart';
import '../model/user_time_sheet_details_respo.dart';
import '../model/user_view_request_response.dart';
import '../model/user_working_hours.dart';
import '../model/utility_respo.dart';
import '../model/viewbooking_response.dart';

class ApiProvider {
  Client client = Client();
  String baseURL = "https://intersmarthosting.in/DEV/ExpressHealth/api";

  Future<LoginUserRespo?> loginUser(
      String username, String password, String userType) async {
    var uri = Uri.parse('$baseURL/account/login');
    try {
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': username,
            'password': password,
            'user_type': userType,
          }));
      debugPrint(jsonEncode(<String, String>{
        'email': username,
        'password': password,
        'user_type': userType,
      }).toString());

      debugPrint(response.body);

      if (response.statusCode == 200) {
        return LoginUserRespo.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserGetResponse> getUserInfo(String token) async {
    try {
      debugPrint("token");
      debugPrint(token);
      var uri = Uri.parse('$baseURL/account/get-user-info');
      debugPrint(uri.toString());
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Token': token,
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return UserGetResponse.fromJson(json.decode(response.body));
      } else {
        return UserGetResponse();
      }
    } catch (e) {
      debugPrint(e.toString());
      return UserGetResponse();
    }
  }

  Future<UtilityResop> fetchUtility() async {
    try {
      var uri = Uri.parse('$baseURL/account/get-utilities');
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return UtilityResop.fromJson(json.decode(response.body));
      } else {
        return UtilityResop();
      }
    } catch (e) {
      debugPrint(e.toString());
      return UtilityResop();
    }
  }

  Future<ProfileQuestionResponse> geProfileQuestions(
      String token, String key, String value) async {
    try {
      var uri = Uri.parse('$baseURL/account/update-questions');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'key': key,
            'value': value,
          }));

      debugPrint("debugPrint Update questions$token");

      debugPrint(jsonEncode(<String, String>{
        'key': key,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ProfileQuestionResponse.fromJson(json.decode(response.body));
      } else {
        return ProfileQuestionResponse();
      }
    } catch (e) {
      debugPrint(e.toString());
      return ProfileQuestionResponse();
    }
  }

  Future<SliftListRepso> fetchShiftList(String date) async {
    try{
      debugPrint("date");
      debugPrint(date);
      var uri = Uri.parse('$baseURL/account/login');
      final response = await client.get(uri);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }catch(e) {
      debugPrint(e.toString());
      return SliftListRepso();
    }

  }





  Future<ProfileUpdateRespo> ProfileUser(
      String token,
      String firstName,
      String lastName,
      String dob,
      String gender,
      String nationality,
      String homeAddress,
      String permissionToWorkInIreland,
      String visaType,
      String phoneNumber,
      String email,
      String ppsNumber,
      String bankIban,
      String bankBic) async {

    try{
      var uri = Uri.parse('$baseURL/account/update-profile');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "first_name": firstName,
            "last_name": lastName,
            "dob": dob,
            "gender": gender,
            "nationality": nationality,
            "home_address": homeAddress,
            "permission_to_work_in_ireland": permissionToWorkInIreland,
            "visa_type": visaType,
            "phone_number": phoneNumber,
            "email": email,
            "pps_number": ppsNumber,
            "bank_iban": bankIban,
            "bank_bic": bankBic,
          }));

      debugPrint(jsonEncode(<String, String>{
        "first_name": firstName,
        "last_name": lastName,
        "dob": dob,
        "nationality": nationality,
        "home_address": homeAddress,
        "permission_to_work_in_ireland": permissionToWorkInIreland,
        "visa_type": visaType,
        "phone_number": phoneNumber,
        "email": email,
        "pps_number": ppsNumber,
        "bank_iban": bankIban,
        "bank_bic": bankBic,
      }).toString());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(response.toString());

      debugPrint(response.body);
      if (response.statusCode == 200) {
        return ProfileUpdateRespo.fromJson(json.decode(response.body));
      } else {
        return ProfileUpdateRespo();
      }
    }catch(e){
      debugPrint(e.toString());
      return ProfileUpdateRespo();
    }

  }

  Future<UserTimeSheetRespo> userGetTimesheet(String token) async {

    try{
      var uri = Uri.parse("$baseURL/user/get-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("debugPrint User_Get_Timesheet$token");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserTimeSheetRespo.fromJson(json.decode(response.body));
      } else {
        return UserTimeSheetRespo();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserTimeSheetRespo();
    }

  }


//new   approvel


  Future<ManagerTimeSheetResponse> managerApprovel(String token) async {

    try{
      var uri = Uri.parse("$baseURL/manager/get-completed-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("Completed approvel$token");
      debugPrint("Completed approvel $uri");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeSheetResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeSheetResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerTimeSheetResponse();
    }

  }









  Future<UserTimeSheetDetailsRespo> userGetTimeDetails(
      String token, String timeShhetId) async {
    try{

      var uri = Uri.parse("$baseURL/user/get-time-sheet-details");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            "time_shhet_id": timeShhetId,
          }));

      debugPrint("debugPrint User_Get_Timesheet_Details$token");

      debugPrint(jsonEncode(<String, String>{
        "time_shhet_id": timeShhetId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserTimeSheetDetailsRespo.fromJson(json.decode(response.body));
      } else {
        return UserTimeSheetDetailsRespo();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserTimeSheetDetailsRespo();
    }

  }

  ///////////////////// MANAGER API

  Future<AcceptJobRequestResponse> AcceptJobRequest(
      String token, String jobRequestRowId) async {

    try{
      var uri = Uri.parse("$baseURL/manager/accept-job-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_request_row_id': jobRequestRowId,
          }));

      debugPrint("debugPrint ACCEPT VIEW JOB REQUEST$token");

      debugPrint(jsonEncode(<String, String>{
        'job_request_row_id': jobRequestRowId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return AcceptJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return AcceptJobRequestResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return AcceptJobRequestResponse();
    }

  }

  Future<ManagerHomeResponse> getManagerHome(String token) async {

    try {
      var uri = Uri.parse("$baseURL/home/get-manager-updates");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("debugPrint ManagerHome ImportantUpdates $token");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerHomeResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerHomeResponse();
      }

    }catch(e){
      debugPrint(e.toString());
      return ManagerHomeResponse();
    }

  }

  Future<ManagerViewRequestResponse> getManagerViewRequest(
      String token, String shiftId) async {

    try{
      var uri = Uri.parse("$baseURL/manager/view-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shiftId,
          }));
      debugPrint("debugPrint VIEW REQUEST$uri");
      debugPrint("debugPrint VIEW REQUEST Id$shiftId");
      debugPrint("debugPrint VIEW REQUEST$token");
      debugPrint(jsonEncode(<String, String>{
        'shift_id': shiftId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerViewRequestResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerViewRequestResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerViewRequestResponse();
    }

  }

  Future<RemoveManagerScheduleResponse> removeManager(
      String token, String rowId) async {

    try{

      var uri = Uri.parse('$baseURL/manager/remove-schedule');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'row_id': rowId,
          }));

      debugPrint("debugPrint TOKEN$token");

      debugPrint(jsonEncode(<String, String>{
        'row_id': rowId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return RemoveManagerScheduleResponse.fromJson(json.decode(response.body));
      } else {
        return RemoveManagerScheduleResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return RemoveManagerScheduleResponse();
    }

  }

  Future<ManagerTimeDetailsResponse> timeDetails(
      String token, String timeShhetId) async {

    try{
      var uri = Uri.parse('$baseURL/manager/get-time-sheet-details');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'time_shhet_id': timeShhetId,
          }));

      debugPrint("debugPrint GET MANAGER TIME DETAILS$token");
      debugPrint("debugPrint GET MANAGER TIME $uri");

      debugPrint(jsonEncode(<String, String>{
        'time_sheet_id': timeShhetId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeDetailsResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeDetailsResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerTimeDetailsResponse();
    }

  }

  Future<ManagerTimeSheetResponse> managerTimeSheet(String token) async {

    try
    {
      var uri = Uri.parse("$baseURL/manager/get-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("debugPrint USERHOME RESPONSE$token");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeSheetResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeSheetResponse();
      }
    }catch(e){
      debugPrint(e.toString().toString());
      return ManagerTimeSheetResponse();
    }

  }

  Future<ManagerGetClientsResponse> managerGetClients(String token) async {

    try{
      var uri = Uri.parse("$baseURL/manager/get-clients");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("debugPrint Manager get clients$token");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerGetClientsResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerGetClientsResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerGetClientsResponse();
    }

  }

  Future<ManagerUnitNameResponse> managerUnitName(
      String token, String clients) async {

    try{
      var uri = Uri.parse('$baseURL/manager/get-unit-name');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'client': clients,
          }));

      debugPrint("debugPrint unit Name $token");

      debugPrint(jsonEncode(<String, String>{
        'client': clients,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerUnitNameResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerUnitNameResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerUnitNameResponse();
    }

  }




  Future<ManagerScheduleListResponse> fetchViewBooking(
      String token, String date) async {

    try{
      debugPrint("View Booking");

      var uri = Uri.parse('$baseURL/manager/get-schedule-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "date": date,
          }));

      debugPrint(uri.toString());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return ManagerScheduleListResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerScheduleListResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerScheduleListResponse();
    }

  }


  Future<UserShoiftCompletedResponse> fetchUserCompleteShift(
      String token) async {

    try{
      var uri = Uri.parse("$baseURL/user/get-completed-shifts");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));
      debugPrint("fetchUserCompleteShift$uri");
      debugPrint("debugPrint USERNAME RESPONSE$token");
      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return UserShoiftCompletedResponse.fromJson(json.decode(response.body));
      } else {
        return UserShoiftCompletedResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserShoiftCompletedResponse();
    }

  }

  Future<UserHomeResponse> getUserHome(String token) async {

    try{
      var uri = Uri.parse("$baseURL/home/get-user-updates");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      debugPrint("debugPrint USERHOME RESPONSE$token");

      debugPrint(jsonEncode(<String, String>{}).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserHomeResponse.fromJson(json.decode(response.body));
      } else {
        return UserHomeResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserHomeResponse();
    }

  }

  Future<ManagerShift> createShiftManager(
    String token,
    String type,
    int rowId,
    String category,
    String userType,
    String jobTitle,
    String hospital,
    String date,
    String timeFrom,
    String timeTo,
    String jobDetails,
    String price,
    String shift,
    String allowances,
  ) async {

    try {
      var response;
      var uri = Uri.parse('$baseURL/manager/add-schedule');
      if (rowId != -1) {
        uri = Uri.parse('$baseURL/manager/edit-schedule');
        response = await client.post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "token": token,
            },
            body: jsonEncode(<String, String>{
              "type": type,
              "row_id": rowId.toString(),
              "category": category,
              "user_type": userType,
              "job_title": jobTitle,
              "hospital": hospital,
              "date": date,
              "time_from": timeFrom,
              "time_to": timeTo,
              "job_details": jobDetails,
              "price": price,
              "allowances": allowances,
              "assigned_to": "",
              "shift": shift,
            }));
      } else {
        response = await client.post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "token": token,
            },
            body: jsonEncode(<String, String>{
              "type": type,
              "category": category,
              "user_type": userType,
              "job_title": jobTitle,
              "hospital": hospital,
              "date": date,
              "time_from": timeFrom,
              "time_to": timeTo,
              "job_details": jobDetails,
              "price": price,
              "allowances": allowances,
              "assigned_to": "",
              "shift": shift,
            }));
      }

      debugPrint(jsonEncode(<String, String>{
        "type": type,
        "row_id": rowId.toString(),
        "category": category,
        "user_type": userType,
        "job_title": jobTitle,
        "hospital": hospital,
        "date": date,
        "time_from": timeFrom,
        "time_to": timeTo,
        "job_details": jobDetails,
        "price": price,
        "allowances": "",
        "assigned_to": "",
        "shift": shift,
      }));
      debugPrint(response.body);
      debugPrint(response.statusCode);
      debugPrint(response.toString());

      if (response.statusCode == 200) {
        return ManagerShift.fromJson(json.decode(response.body));
      } else {
        return ManagerShift();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerShift();
    }

  }

  Future<GetAvailableUserByDate> fetchGetAvailableUserByDate(
      String token, String date, String shifttype) async {
    try{
      debugPrint("GetAvailableUserByDate  CALLING");

      var uri = Uri.parse('$baseURL/manager/get-available-user-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "date": date,
            "shifttype": shifttype,
          }));

      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return GetAvailableUserByDate.fromJson(json.decode(response.body));
      } else {
        return GetAvailableUserByDate();
      }
    }catch(e){
      debugPrint(e.toString());
      return GetAvailableUserByDate();
    }

  }

  Future<UserGetScheduleByDate> getUserScheduleByDate(
      String token, String date) async {

    try
    {
      var uri = Uri.parse('$baseURL/user/get-schedule-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'date': date,
          }));

      debugPrint("debugPrint DATE$token");

      debugPrint(jsonEncode(<String, String>{
        'date': date,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByDate.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByDate();
      }

    }catch(e){
      debugPrint(e.toString());
      return UserGetScheduleByDate();
    }

  }

  Future<UserGetScheduleByMonthYear> getUserScheduleByMonthYear(
      String token, String month, String year) async {

    try{
      var uri = Uri.parse('$baseURL/manager/get-schedule-by-month');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'month': month,
            'year': year,
          }));

      debugPrint("debugPrint MONTH YEAR $token");

      debugPrint(jsonEncode(<String, String>{
        'month': month,
        'year': year,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByMonthYear.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByMonthYear();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserGetScheduleByMonthYear();
    }


  }

  Future<UserGetScheduleByYear> userScheduleByYears(
      String token, String year) async {

    try{

      var uri = Uri.parse('$baseURL/user/get-schedule-by-year');

      debugPrint(uri.toString());

      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'year': year,
          }));

      debugPrint("debugPrint  YEAR $token");
      debugPrint(jsonEncode(<String, String>{
        'year': year,
      }).toString());

      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByYear.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByYear();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserGetScheduleByYear();
    }

  }

  Future<ManagerGetScheduleByYear?> managerScheduleByYears(
      String token, String year) async {

    try{

      var uri = Uri.parse('$baseURL/manager/get-schedule-by-year');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'year': year,
          }));
      debugPrint("debugPrint  YEAR $token");
      debugPrint(jsonEncode(<String, String>{
        'year': year,
      }).toString());

      debugPrint(uri.toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return ManagerGetScheduleByYear.fromJson(json.decode(response.body));
      } else {
        return ManagerGetScheduleByYear();
      }
    }catch(e){
      debugPrint(e.toString());
      return ManagerGetScheduleByYear();
    }

  }

  Future<UserJobRequestResponse> getUserJobRequest(
      String token, String jobId) async {

    try{

      var uri = Uri.parse("$baseURL/user/job-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_id': jobId,
          }));
      debugPrint("debugPrint JOB REQUEST $token");
      debugPrint(jsonEncode(<String, String>{
        'job_id': jobId,
      }).toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return UserJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserJobRequestResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserJobRequestResponse();
    }

  }

  Future<UserViewRequestResponse> getUserViewRequest(String token) async {
    try{

      var uri = Uri.parse("$baseURL/user/view-request");


      final response = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );
      debugPrint(uri.toString());
      debugPrint(token);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return UserViewRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserViewRequestResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserViewRequestResponse();
    }




  }

  Future<GetUserShiftDetailsResponse> getUserShiftDetails(
      String token, String shiftId) async {

    try{
      var uri = Uri.parse("$baseURL/user/get-shift-details");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shiftId,
          }));

      debugPrint("debugPrint GET USER SHIFT DETAILS $token");

      debugPrint(jsonEncode(<String, String>{
        'shift_id': shiftId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return GetUserShiftDetailsResponse.fromJson(json.decode(response.body));
      } else {
        return GetUserShiftDetailsResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return GetUserShiftDetailsResponse();
    }

  }

  Future<UserCancelJobRequestResponse> cancelJobRequest(
      String token, String jobRequestRowId) async {

    try{
      var uri = Uri.parse("$baseURL/user/cancel-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_request_row_id': jobRequestRowId,
          }));

      debugPrint("debugPrint USER CANCEL JOB REQUEST$token");

      debugPrint(jsonEncode(<String, String>{
        'job_request_row_id': jobRequestRowId,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserCancelJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserCancelJobRequestResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserCancelJobRequestResponse();
    }

  }

  Future<AddUserAvailabilityResponse> getAddUserAvailability(
      String token, String date, String availability) async {

    try{
      var uri = Uri.parse("$baseURL/user/add-availability");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'date': date,
            'availability': availability,
          }));

      debugPrint("debugPrint ADD USER AVAILABILITY$token");

      debugPrint(jsonEncode(<String, String>{
        'date': date,
        'availability': availability,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return AddUserAvailabilityResponse.fromJson(json.decode(response.body));
      } else {
        return AddUserAvailabilityResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return AddUserAvailabilityResponse();
    }

  }

  Future<UserAvailabilitydateResponse> getUserAvailability(
      String token, String fromDate, String toDate) async {

    try{
      var uri = Uri.parse("$baseURL/user/get-available-user-between-date");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'from_date': fromDate,
            'to_date': toDate,
          }));

      debugPrint("debugPrint USER AVAILABILITY BETWEEN DATE $token");

      debugPrint(jsonEncode(<String, String>{
        'from_date': fromDate,
        'to_date': toDate,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserAvailabilitydateResponse.fromJson(json.decode(response.body));
      } else {
        return UserAvailabilitydateResponse();
      }

    }catch(e){
      debugPrint(e.toString());
      return UserAvailabilitydateResponse();
    }

  }

  Future<UserWorkingHoursResponse> addUserWorkingHours(
      String token,
      String shiftId,
      String startTime,
      String endTime,
      String workingHours) async {

    try{

      var uri = Uri.parse("$baseURL/user/add-working-hours");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shiftId,
            'start_time': startTime,
            'end_time': endTime,
            'working_hours': workingHours,
          }));

      debugPrint("ADD USER WORKING HOURS $token");

      debugPrint(jsonEncode(<String, String>{
        'shift_id': shiftId,
        'start_time': startTime,
        'end_time': endTime,
        'working_hours': workingHours,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserWorkingHoursResponse.fromJson(json.decode(response.body));
      } else {
        return UserWorkingHoursResponse();
      }
    }catch(e){
      debugPrint(e.toString());
      return UserWorkingHoursResponse();
    }

  }

  Future<UserDocumentsResponse> uploadUserDocuments(
      String token, String files, String type, String expiryDate) async {

    try{


      var uri = Uri.parse("$baseURL/account/upload-user-documents");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'files': files,
            'type': type,
            'expiry_date': expiryDate,
          }));

      debugPrint("UPLOAD USER DOCUMENTS $token");

      debugPrint(jsonEncode(<String, String>{
        'files': files,
        'type': type,
        'expiry_date': expiryDate,
      }).toString());
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return UserDocumentsResponse.fromJson(json.decode(response.body));
      } else {
        return UserDocumentsResponse();
      }

    }catch(e){
      debugPrint(e.toString());
      return UserDocumentsResponse();
    }

  }

  //////////////CATEGORIES

  Future<SliftListRepso> fetchConfirm() async {

    try{

      debugPrint("CONFIRMED");

      var uri = Uri.parse(
          'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
      final response = await client.get(uri);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }

    catch(e){
      debugPrint(e.toString());
      return SliftListRepso();
    }

  }

  Future<SliftListRepso> fetchNotification() async {

    try{
      debugPrint("date");
      var uri = Uri.parse(
          'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
      final response = await client.get(uri);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }catch(e){
      debugPrint(e.toString());
      return SliftListRepso();
    }
    }

}
