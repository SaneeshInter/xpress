import 'dart:convert';
import 'package:http/http.dart';
import 'package:xpresshealthdev/model/login_response.dart';
import 'package:xpresshealthdev/model/user_get_shift_details.dart';
import 'package:xpresshealthdev/model/user_home_response.dart';
import '../model/accept_job_request.dart';
import '../model/get_available_user_by_date.dart';
import '../model/manager_get_time.dart';
import '../model/manager_home_response.dart';
import '../model/manager_response.dart';
import '../model/manager_timesheet.dart';
import '../model/manager_view_request.dart';
import '../model/remove_manager_schedule.dart';
import '../model/shift_list_response.dart';
import '../model/user_add_availability.dart';
import '../model/user_availability_btw_date.dart';
import '../model/user_cancel_jobrequest.dart';
import '../model/user_complted_shift.dart';
import '../model/user_documents_response.dart';
import '../model/user_get_response.dart';
import '../model/user_getschedule_by_month_year.dart';
import '../model/user_getschedule_bydate.dart';
import '../model/user_job_request.dart';
import '../model/user_profile_update.dart';
import '../model/user_view_request_response.dart';
import '../model/user_working_hours.dart';
import '../model/utility_respo.dart';
import '../model/viewbooking_response.dart';
class ApiProvider {
  Client client = Client();
  String BASE_URL = "https://intersmarthosting.in/DEV/ExpressHealth/api";

  Future<LoginUserRespo> loginUser(String username, String password) async {
    var uri = Uri.parse(BASE_URL + '/account/login');
    final response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': username,
          'password': password,
        }));

    print(jsonEncode(<String, String>{
      'email': username,
      'password': password,
    }).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return LoginUserRespo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserGetResponse> getUserInfo(String token) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<UtilityResop> fetchUtility() async {
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
      throw Exception('Failed to load post');
    }
  }
  Future<SliftListRepso> fetchShiftList(String date) async {
    print("date");
    print(date);
    var uri = Uri.parse(BASE_URL + '/account/login');
    final response = await client.get(uri);
    print(response);
    if (response.statusCode == 200) {
      return SliftListRepso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
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
      throw Exception('Failed to load post');
    }
  }
  ///////////////////// MANAGER API
  Future<ManagerScheduleListResponse> fetchViewbooking(
      String token, String date) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<AcceptJobRequestResponse> AcceptJobRequest(
      String token, String job_request_row_id) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerHomeResponse> getManagerHome(String token) async {
    var uri = Uri.parse(BASE_URL + "/home/get-manager-updates");
    final response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(<String, String>{}));

    print("PRINT MANAGERHOME RESPONSE" + token);

    print(jsonEncode(<String, String>{}).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return ManagerHomeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerViewRequestResponse> getManagerViewRequest(
      String token, String shift_id) async {
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
    print("PRINT VIEW REQUEST" + shift_id);
    print("PRINT VIEW REQUEST" + token);
    print(jsonEncode(<String, String>{
      'shift_id': shift_id,
    }).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return ManagerViewRequestResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<RemoveManagerScheduleResponse> removeManager(
      String token, String rowId) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerTimeDetailsResponse> timeDetails(
      String token, String time_shhet_id) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerTimeSheetResponse> managerTimeSheet(
      String token) async {
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
      throw Exception('Failed to load post');
    }
  }

  //////////////USER
  Future<ManagerScheduleListResponse> fetchUserListByDate(
      String token, String date) async {
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

    print(response.body);
    print(response.statusCode);
    print(response.toString());
    if (response.statusCode == 200) {
      return ManagerScheduleListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }








  Future<UserShoiftCompletedResponse> fetchUserCompleteShift(
      String token) async {
    var uri = Uri.parse(BASE_URL + "/user/get-completed-shifts");
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
      return UserShoiftCompletedResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserHomeResponse> getUserHome(String token) async {
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
      throw Exception('Failed to load post');
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
      throw Exception('Failed to load post');
    }
  }

  Future<GetAvailableUserByDate> fetchGetAvailableUserByDate(
      String token, String date, String shifttype) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<UserGetScheduleByDate> getUserScheduleByDate(
      String token, String date) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<UserGetScheduleByMonthYear> getUserScheduleByMonthYear(
      String token, String month, String year) async {
    var uri = Uri.parse(BASE_URL + '/get-schedule-by-month');
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
      throw Exception('Failed to load post');
    }
  }

  Future<UserJobRequestResponse> getUserJobRequest(
      String token, String job_id) async {
    var uri = Uri.parse(BASE_URL + "/user/job-request");
    final response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(<String, String>{
          'job_id': job_id,
        }));

    print("PRINT JOB REQUEST" + token);

    print(jsonEncode(<String, String>{
      'job_id': job_id,
    }).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return UserJobRequestResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserViewRequestResponse> getUserViewRequest(String token) async {
    var uri = Uri.parse(BASE_URL + "/user/view-request");
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
      throw Exception('Failed to load post');
    }
  }

  Future<GetUserShiftDetailsResponse> getUserShiftDetails(
      String token, String shift_id) async {
    var uri = Uri.parse(BASE_URL + "/user/get-shift-details");
    final response = await client.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(<String, String>{
          'shift_id': shift_id,
        }));

    print("PRINT GET USER SHIFT DETAILS" + token);

    print(jsonEncode(<String, String>{
      'shift_id': shift_id,
    }).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return GetUserShiftDetailsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserCancelJobRequestResponse> getUserCanceljobrequest(
      String token, String job_request_row_id) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<AddUserAvailabilityResponse> getaddUserAvailability(
      String token, String date, String availability) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<UserAvailabilitydateResponse> getUserAvailability(
      String token, String from_date, String to_date) async {
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
      throw Exception('Failed to load post');
    }
  }

  Future<UserWorkingHoursResponse> addUserWorkingHours(
      String token, String shift_id, String start_time, String end_time) async {
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
        }));

    print("ADD USER WORKING HOURS" + token);

    print(jsonEncode(<String, String>{
      'shift_id': shift_id,
      'start_time': start_time,
      'end_time': end_time,
    }).toString());
    print(response.body);

    if (response.statusCode == 200) {
      return UserWorkingHoursResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }





  Future<UserDocumentsResponse> uploadUserDocuments(
      String token, String files, String type, String expiry_date) async {
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
      throw Exception('Failed to load post');
    }
  }

                                                               //////////////CATEGORIES

  Future<SliftListRepso> fetchConfirm() async {
    print("CONFIRMED");

    var uri = Uri.parse(
        'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
    final response = await client.get(uri);
    print(response);
    if (response.statusCode == 200) {
      return SliftListRepso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<SliftListRepso> fetchNotification() async {
    print("date");

    var uri = Uri.parse(
        'https://agasthyapix.yodser.com/api/categories.asmx/fillCategories');
    final response = await client.get(uri);
    print(response);
    if (response.statusCode == 200) {
      return SliftListRepso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }


}
