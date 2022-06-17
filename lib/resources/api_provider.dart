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
  String BASE_URL = "https://intersmarthosting.in/DEV/ExpressHealth/api";

  Future<LoginUserRespo?> loginUser(
      String username, String password, String user_type,String device_id) async {
    var uri = Uri.parse('$BASE_URL/account/login');
    try {
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': username,
            'password': password,
            'user_type': user_type,
            'device_id': device_id,
          }));
      print(jsonEncode(<String, String>{
        'email': username,
        'password': password,
        'user_type': user_type,
        'device_id': device_id,
      }).toString());

      print(response.body);

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
      print("token");
      print(token);
      var uri = Uri.parse(BASE_URL + '/account/get-user-info');
      print(uri);
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Token': token,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return UserGetResponse.fromJson(json.decode(response.body));
      } else {
        return UserGetResponse();
      }
    } catch (e) {

      print(e.toString());
      return UserGetResponse();
    }
  }

  Future<UtilityResop> fetchUtility() async {
    try {
      var uri = Uri.parse(BASE_URL + '/account/get-utilities');
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return UtilityResop.fromJson(json.decode(response.body));
      } else {
        return UtilityResop();
      }
    } catch (e) {
      print(e.toString());
      return UtilityResop();
    }
  }

  Future<ProfileQuestionResponse> geProfileQuestions(
      String token, String key, String value) async {
    try {
      var uri = Uri.parse(BASE_URL + '/account/update-questions');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'key': key,
            'value': value,
          }));

      print("Print Update questions" + token);

      print(jsonEncode(<String, String>{
        'key': key,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ProfileQuestionResponse.fromJson(json.decode(response.body));
      } else {
        return ProfileQuestionResponse();
      }
    } catch (e) {
      print(e.toString());
      return ProfileQuestionResponse();
    }
  }

  Future<SliftListRepso> fetchShiftList(String date) async {
    try{
      print("date");
      print(date);
      var uri = Uri.parse(BASE_URL + '/account/login');
      final response = await client.get(uri);
      print(response);
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }catch(e) {
      print(e.toString());
      return SliftListRepso();
    }

  }





  Future<ProfileUpdateRespo> ProfileUser(
      String token,
      String first_name,
      String last_name,
      String dob,
      String gender,
      String nationality,
      String home_address,
      String permission_to_work_in_ireland,
      String visa_type,
      String phone_number,
      String email,
      String pps_number,
      String bank_iban,
      String bank_bic) async {

    try{
      var uri = Uri.parse(BASE_URL + '/account/update-profile');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "first_name": first_name,
            "last_name": last_name,
            "dob": dob,
            "gender": gender,
            "nationality": nationality,
            "home_address": home_address,
            "permission_to_work_in_ireland": permission_to_work_in_ireland,
            "visa_type": visa_type,
            "phone_number": phone_number,
            "email": email,
            "pps_number": pps_number,
            "bank_iban": bank_iban,
            "bank_bic": bank_bic,
          }));

      print(jsonEncode(<String, String>{
        "first_name": first_name,
        "last_name": last_name,
        "dob": dob,
        "nationality": nationality,
        "home_address": home_address,
        "permission_to_work_in_ireland": permission_to_work_in_ireland,
        "visa_type": visa_type,
        "phone_number": phone_number,
        "email": email,
        "pps_number": pps_number,
        "bank_iban": bank_iban,
        "bank_bic": bank_bic,
      }).toString());
      print(response.body);
      print(response.statusCode);
      print(response.toString());

      print(response.body);
      if (response.statusCode == 200) {
        return ProfileUpdateRespo.fromJson(json.decode(response.body));
      } else {
        return ProfileUpdateRespo();
      }
    }catch(e){
      print(e.toString());
      return ProfileUpdateRespo();
    }

  }

  Future<UserTimeSheetRespo> userGetTimesheet(String token) async {

    try{
      var uri = Uri.parse(BASE_URL + "/user/get-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("PRINT User_Get_Timesheet" + token);

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserTimeSheetRespo.fromJson(json.decode(response.body));
      } else {
        return UserTimeSheetRespo();
      }
    }catch(e){
      print(e.toString());
      return UserTimeSheetRespo();
    }

  }


//new   approval


  Future<ManagerTimeSheetResponse> managerApprovel(String token) async {

    try{
      var uri = Uri.parse(BASE_URL + "/manager/get-completed-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("Completed approvel" + token);
      print("Completed approvel " + uri.toString());

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeSheetResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeSheetResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerTimeSheetResponse();
    }

  }


  Future<UserTimeSheetDetailsRespo> userGetTimeDetails(
      String token, String time_shhet_id) async {
    try{

      var uri = Uri.parse(BASE_URL + "/user/get-time-sheet-details");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            "time_shhet_id": time_shhet_id,
          }));

      print("PRINT User_Get_Timesheet_Details" + token);

      print(jsonEncode(<String, String>{
        "time_shhet_id": time_shhet_id,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserTimeSheetDetailsRespo.fromJson(json.decode(response.body));
      } else {
        return UserTimeSheetDetailsRespo();
      }
    }catch(e){
      print(e.toString());
      return UserTimeSheetDetailsRespo();
    }

  }

  ///////////////////// MANAGER API

  Future<AcceptJobRequestResponse> AcceptJobRequest(
      String token, String job_request_row_id) async {

    try{
      var uri = Uri.parse(BASE_URL + "/manager/accept-job-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_request_row_id': job_request_row_id,
          }));

      print("PRINT ACCEPT VIEW JOB REQUEST" + token);

      print(jsonEncode(<String, String>{
        'job_request_row_id': job_request_row_id,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return AcceptJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return AcceptJobRequestResponse();
      }
    }catch(e){
      print(e.toString());
      return AcceptJobRequestResponse();
    }

  }

  Future<ManagerHomeResponse> getManagerHome(String token) async {

    try {
      var uri = Uri.parse(BASE_URL + "/home/get-manager-updates");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("Print ManagerHome ImportantUpdates " + token);

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerHomeResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerHomeResponse();
      }

    }catch(e){
      print(e.toString());
      return ManagerHomeResponse();
    }

  }

  Future<ManagerViewRequestResponse> getManagerViewRequest(
      String token, String shift_id) async {

    try{
      var uri = Uri.parse(BASE_URL + "/manager/view-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shift_id,
          }));
      print("PRINT VIEW REQUEST" + uri.toString());
      print("PRINT VIEW REQUEST Id" + shift_id);
      print("PRINT VIEW REQUEST" + token);
      print(jsonEncode(<String, String>{
        'shift_id': shift_id,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerViewRequestResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerViewRequestResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerViewRequestResponse();
    }

  }

  Future<RemoveManagerScheduleResponse> removeManager(
      String token, String rowId) async {

    try{

      var uri = Uri.parse(BASE_URL + '/manager/remove-schedule');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'row_id': rowId,
          }));

      print("PRINT TOKEN" + token);

      print(jsonEncode(<String, String>{
        'row_id': rowId,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return RemoveManagerScheduleResponse.fromJson(json.decode(response.body));
      } else {
        return RemoveManagerScheduleResponse();
      }
    }catch(e){
      print(e.toString());
      return RemoveManagerScheduleResponse();
    }

  }

  Future<ManagerTimeDetailsResponse> timeDetails(
      String token, String time_shhet_id) async {

    try{
      var uri = Uri.parse(BASE_URL + '/manager/get-time-sheet-details');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'time_shhet_id': time_shhet_id,
          }));

      print("PRINT GET MANAGER TIME DETAILS" + token);
      print("PRINT GET MANAGER TIME " + uri.toString());

      print(jsonEncode(<String, String>{
        'time_shhet_id': time_shhet_id,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeDetailsResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeDetailsResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerTimeDetailsResponse();
    }

  }

  Future<ManagerTimeSheetResponse> managerTimeSheet(String token) async {

    try
    {
      var uri = Uri.parse(BASE_URL + "/manager/get-time-sheet");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("PRINT USERHOME RESPONSE" + token);

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerTimeSheetResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerTimeSheetResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerTimeSheetResponse();
    }

  }

  Future<ManagerGetClientsResponse> managerGetClients(String token) async {

    try{
      var uri = Uri.parse(BASE_URL + "/manager/get-clients");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("PRINT Manager get clients" + token);

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerGetClientsResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerGetClientsResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerGetClientsResponse();
    }

  }

  Future<ManagerUnitNameResponse> managerUnitName(
      String token, String clients) async {

    try{
      var uri = Uri.parse(BASE_URL + '/manager/get-unit-name');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'client': clients,
          }));

      print("PRINT unit Nmae" + token);

      print(jsonEncode(<String, String>{
        'client': clients,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerUnitNameResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerUnitNameResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerUnitNameResponse();
    }

  }




  Future<ManagerScheduleListResponse> fetchViewbooking(
      String token, String date) async {

    try{
      print("View Booking");

      var uri = Uri.parse(BASE_URL + '/manager/get-schedule-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "date": date,
          }));

      print(uri.toString());
      print(response.body);
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 200) {
        return ManagerScheduleListResponse.fromJson(json.decode(response.body));
      } else {
        return ManagerScheduleListResponse();
      }
    }catch(e){
      print(e.toString());
      return ManagerScheduleListResponse();
    }

  }


  Future<UserShoiftCompletedResponse> fetchUserCompleteShift(
      String token) async {

    try{
      var uri = Uri.parse(BASE_URL + "/user/get-completed-shifts");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));
      print("fetchUserCompleteShift" + uri.toString());
      print("PRINT USERHOME RESPONSE" + token);
      print(jsonEncode(<String, String>{}).toString());
      print(response.body);
      if (response.statusCode == 200) {
        return UserShoiftCompletedResponse.fromJson(json.decode(response.body));
      } else {
        return UserShoiftCompletedResponse();
      }
    }catch(e){
      print(e.toString());
      return UserShoiftCompletedResponse();
    }

  }

  Future<UserHomeResponse> getUserHome(String token) async {

    try{
      var uri = Uri.parse(BASE_URL + "/home/get-user-updates");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{}));

      print("PRINT USERHOME RESPONSE" + token);

      print(jsonEncode(<String, String>{}).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserHomeResponse.fromJson(json.decode(response.body));
      } else {
        return UserHomeResponse();
      }
    }catch(e){
      print(e.toString());
      return UserHomeResponse();
    }

  }

  Future<ManagerShift> CreateShiftManager(
    String token,
    String type,
    int row_id,
    String category,
    String user_type,
    String job_title,
    String hospital,
    String date,
    String time_from,
    String time_to,
    String job_details,
    String price,
    String shift,
    String allowances,
  ) async {

    try {
      var response;
      var uri = Uri.parse(BASE_URL + '/manager/add-schedule');
      if (row_id != -1) {
        uri = Uri.parse(BASE_URL + '/manager/edit-schedule');
        response = await client.post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "token": token,
            },
            body: jsonEncode(<String, String>{
              "type": type,
              "row_id": row_id.toString(),
              "category": category,
              "user_type": user_type,
              "job_title": job_title,
              "hospital": hospital,
              "date": date,
              "time_from": time_from,
              "time_to": time_to,
              "job_details": job_details,
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
              "user_type": user_type,
              "job_title": job_title,
              "hospital": hospital,
              "date": date,
              "time_from": time_from,
              "time_to": time_to,
              "job_details": job_details,
              "price": price,
              "allowances": allowances,
              "assigned_to": "",
              "shift": shift,
            }));
      }

      print(jsonEncode(<String, String>{
        "type": type,
        "row_id": row_id.toString(),
        "category": category,
        "user_type": user_type,
        "job_title": job_title,
        "hospital": hospital,
        "date": date,
        "time_from": time_from,
        "time_to": time_to,
        "job_details": job_details,
        "price": price,
        "allowances": "",
        "assigned_to": "",
        "shift": shift,
      }));
      print(response.body);
      print(response.statusCode);
      print(response.toString());

      if (response.statusCode == 200) {
        return ManagerShift.fromJson(json.decode(response.body));
      } else {
        return ManagerShift();
      }
    }catch(e){
      print(e.toString());
      return ManagerShift();
    }

  }

  Future<GetAvailableUserByDate> fetchGetAvailableUserByDate(
      String token, String date, String shifttype) async {
    try{
      print("GetAvailableUserByDate  CALLING");

      var uri = Uri.parse(BASE_URL + '/manager/get-available-user-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(<String, String>{
            "date": date,
            "shifttype": shifttype,
          }));

      print(response.body);
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 200) {
        return GetAvailableUserByDate.fromJson(json.decode(response.body));
      } else {
        return GetAvailableUserByDate();
      }
    }catch(e){
      print(e.toString());
      return GetAvailableUserByDate();
    }

  }

  Future<UserGetScheduleByDate> getUserScheduleByDate(
      String token, String date) async {

    try
    {
      var uri = Uri.parse(BASE_URL + '/user/get-schedule-by-date');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'date': date,
          }));

      print("PRINT DATE" + token);

      print(jsonEncode(<String, String>{
        'date': date,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByDate.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByDate();
      }

    }catch(e){
      print(e.toString());
      return UserGetScheduleByDate();
    }

  }

  Future<UserGetScheduleByMonthYear> getUserScheduleByMonthYear(
      String token, String month, String year) async {

    try{
      var uri = Uri.parse(BASE_URL + '/manager/get-schedule-by-month');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'month': month,
            'year': year,
          }));

      print("PRINT MONTH YEAR" + token);

      print(jsonEncode(<String, String>{
        'month': month,
        'year': year,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByMonthYear.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByMonthYear();
      }
    }catch(e){
      print(e.toString());
      return UserGetScheduleByMonthYear();
    }


  }

  Future<UserGetScheduleByYear> userScheduleByYears(
      String token, String year) async {

    try{

      var uri = Uri.parse(BASE_URL + '/user/get-schedule-by-year');

      print(uri);

      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'year': year,
          }));

      print("PRINT  YEAR" + token);
      print(jsonEncode(<String, String>{
        'year': year,
      }).toString());

      print(response.body);

      if (response.statusCode == 200) {
        return UserGetScheduleByYear.fromJson(json.decode(response.body));
      } else {
        return UserGetScheduleByYear();
      }
    }catch(e){
      print(e.toString());
      return UserGetScheduleByYear();
    }

  }

  Future<ManagerGetScheduleByYear?> managerScheduleByYears(
      String token, String year) async {

    try{

      var uri = Uri.parse(BASE_URL + '/manager/get-schedule-by-year');
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'year': year,
          }));
      print("PRINT  YEAR" + token);
      print(jsonEncode(<String, String>{
        'year': year,
      }).toString());

      print(uri.toString());
      print(response.body);

      if (response.statusCode == 200) {
        return ManagerGetScheduleByYear.fromJson(json.decode(response.body));
      } else {
        return ManagerGetScheduleByYear();
      }
    }catch(e){
      print(e.toString());
      return ManagerGetScheduleByYear();
    }

  }

  Future<UserJobRequestResponse> getUserJobRequest(
      String token, String job_id) async {

    try{

      var uri = Uri.parse(BASE_URL + "/user/job-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_id': job_id,
          }));
      print("PRINT JOB REQUEST$token");
      print(jsonEncode(<String, String>{
        'job_id': job_id,
      }).toString());
      print(response.body);
      if (response.statusCode == 200) {
        return UserJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserJobRequestResponse();
      }
    }catch(e){
      print(e.toString());
      return UserJobRequestResponse();
    }

  }

  Future<UserViewRequestResponse> getUserViewRequest(String token) async {
    try{

      var uri = Uri.parse("$BASE_URL/user/view-request");


      final response = await client.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );
      print(uri.toString());
      print(token);
      print(response.body);
      if (response.statusCode == 200) {
        return UserViewRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserViewRequestResponse();
      }
    }catch(e){
      print(e.toString());
      return UserViewRequestResponse();
    }




  }

  Future<GetUserShiftDetailsResponse> getUserShiftDetails(
      String token, String shift_id) async {

    try{
      var uri = Uri.parse("$BASE_URL/user/get-shift-details");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shift_id,
          }));

      print("PRINT GET USER SHIFT DETAILS$token");
      print("uri  $uri");

      print(jsonEncode(<String, String>{
        'shift_id': shift_id,
      }).toString());
      debugPrint("here  ${response.body}");

      if (response.statusCode == 200) {
        return GetUserShiftDetailsResponse.fromJson(json.decode(response.body));
      } else {
        return GetUserShiftDetailsResponse();
      }
    }catch(e){
      print(e.toString());
      return GetUserShiftDetailsResponse();
    }

  }

  Future<UserCancelJobRequestResponse> canceljobrequest(
      String token, String job_request_row_id) async {

    try{
      var uri = Uri.parse(BASE_URL + "/user/cancel-request");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'job_request_row_id': job_request_row_id,
          }));

      print("PRINT USER CANCEL JOB REQUEST" + token);

      print(jsonEncode(<String, String>{
        'job_request_row_id': job_request_row_id,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserCancelJobRequestResponse.fromJson(json.decode(response.body));
      } else {
        return UserCancelJobRequestResponse();
      }
    }catch(e){
      print(e.toString());
      return UserCancelJobRequestResponse();
    }

  }

  Future<AddUserAvailabilityResponse> getaddUserAvailability(
      String token, String date, String availability) async {

    try{
      var uri = Uri.parse(BASE_URL + "/user/add-availability");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'date': date,
            'availability': availability,
          }));

      print("PRINT ADD USER AVAILABILTY" + token);

      print(jsonEncode(<String, String>{
        'date': date,
        'availability': availability,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return AddUserAvailabilityResponse.fromJson(json.decode(response.body));
      } else {
        return AddUserAvailabilityResponse();
      }
    }catch(e){
      print(e.toString());
      return AddUserAvailabilityResponse();
    }

  }

  Future<UserAvailabilitydateResponse> getUserAvailability(
      String token, String from_date, String to_date) async {

    try{
      var uri = Uri.parse(BASE_URL + "/user/get-available-user-between-date");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'from_date': from_date,
            'to_date': to_date,
          }));

      print("PRINT USER AVAILABILTY BETWEEN DATE" + token);

      print(jsonEncode(<String, String>{
        'from_date': from_date,
        'to_date': to_date,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserAvailabilitydateResponse.fromJson(json.decode(response.body));
      } else {
        return UserAvailabilitydateResponse();
      }

    }catch(e){
      print(e.toString());
      return UserAvailabilitydateResponse();
    }

  }

  Future<UserWorkingHoursResponse> addUserWorkingHours(
      String token,
      String shift_id,
      String start_time,
      String end_time,
      String working_hours) async {

    try{

      var uri = Uri.parse(BASE_URL + "/user/add-working-hours");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'shift_id': shift_id,
            'start_time': start_time,
            'end_time': end_time,
            'working_hours': working_hours,
          }));

      print("ADD USER WORKING HOURS" + token);

      print(jsonEncode(<String, String>{
        'shift_id': shift_id,
        'start_time': start_time,
        'end_time': end_time,
        'working_hours': working_hours,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserWorkingHoursResponse.fromJson(json.decode(response.body));
      } else {
        return UserWorkingHoursResponse();
      }
    }catch(e){
      print(e.toString());
      return UserWorkingHoursResponse();
    }

  }

  Future<UserDocumentsResponse> uploadUserDocuments(
      String token, String files, String type, String expiry_date) async {

    try{


      var uri = Uri.parse(BASE_URL + "/account/upload-user-documents");
      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token,
          },
          body: jsonEncode(<String, String>{
            'files': files,
            'type': type,
            'expiry_date': expiry_date,
          }));

      print("UPLOAD USER DOCUMENTS" + token);

      print(jsonEncode(<String, String>{
        'files': files,
        'type': type,
        'expiry_date': expiry_date,
      }).toString());
      print(response.body);

      if (response.statusCode == 200) {
        return UserDocumentsResponse.fromJson(json.decode(response.body));
      } else {
        return UserDocumentsResponse();
      }

    }catch(e){
      print(e.toString());
      return UserDocumentsResponse();
    }

  }

  //////////////CATEGORIES

  Future<SliftListRepso> fetchConfirm() async {

    try{

      print("CONFIRMED");

      var uri = Uri.parse(
          'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
      final response = await client.get(uri);
      print(response);
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }

    catch(e){
      print(e.toString());
      return SliftListRepso();
    }

  }

  Future<SliftListRepso> fetchNotification() async {

    try{

      print("date");

      var uri = Uri.parse(
          'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
      final response = await client.get(uri);
      print(response);
      if (response.statusCode == 200) {
        return SliftListRepso.fromJson(json.decode(response.body));
      } else {
        return SliftListRepso();
      }
    }catch(e){
      print(e.toString());
      return SliftListRepso();
    }
    }

}
