import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/manager_approve_timesheet_respo.dart';
import '../model/manager_response.dart';
import '../model/time_sheet_upload_respo.dart';
import '../model/user_documents_response.dart';

class ApiFileProvider {
  String baseURL = "https://intersmarthosting.in/DEV/ExpressHealth/api";

  Future<TimeSheetUploadRespo> asyncFileUpload(
      String token, String ids, File file) async {
    var uri = Uri.parse('$baseURL/user/add-time-sheet');
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", uri);
    var headers = <String, String>{
      'token': token,
    };
    //add text fields
    request.fields["shift_id"] = ids;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file", file.path);
    //add multipart to request
    request.files.add(pic);
    request.headers.addAll(headers);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);

    if (response.statusCode == 200) {
      return TimeSheetUploadRespo.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<UserDocumentsResponse> uploadUserDocuments(
      String token, File files, String type, String expiryDate) async {
    var uri = Uri.parse('$baseURL/account/upload-user-documents');
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", uri);
    var headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      'Token': token,
      'token': token,
    };
    //add text fields

    print(files.path);
    print(type);
    print(token);
    print("Url: ${uri.toString()} header: ${headers.toString()} ${files.path}");
    request.fields["type"] = type;
    // request.fields["expiry_date"] = expiry_date;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("files", files.absolute.path);
    //add multipart to request
    request.files.add(pic);
    request.headers.addAll(headers);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("response.statusCode");
    print(response.statusCode);
    debugPrint(response.toString());
    debugPrint(responseString);

    if (response.statusCode == 200) {
      return UserDocumentsResponse.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerShift> createShiftManagers(
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
    String unitName,
    String poCode,
  ) async {
    debugPrint("type :$type row_id : ${rowId}category :${category}user_type :${userType}job_title :${jobTitle}hospital :${hospital}time_from :${timeFrom}time_to :${timeTo}job_details :${jobDetails}price :${price}shift :${shift}allowances :${allowances}unit_name :$unitName");

    var uri = Uri.parse('$baseURL/manager/add-schedule');

    if (rowId != -1) {
      uri = Uri.parse('$baseURL/manager/edit-schedule');
    }
    var request = http.MultipartRequest("POST", uri);

    request.fields["type"] = type;
    if (rowId != -1) {
      debugPrint("edit");
      request.fields["row_id"] = rowId.toString();
    }
    request.fields["category"] = category;
    request.fields["user_type"] = userType;
    request.fields["job_title"] = jobTitle;
    request.fields["hospital"] = hospital;
    request.fields["date"] = date;
    request.fields["time_from"] = timeFrom;
    request.fields["time_to"] = timeTo;
    request.fields["job_details"] = jobDetails;
    request.fields["price"] = price;
    request.fields["allowances"] = allowances;
    request.fields["assigned_to"] = "";
    request.fields["shift"] = shift;
    request.fields["unit_name"] = unitName;
    request.fields["po_code"] = poCode;
    debugPrint(uri.toString());
    var headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      'Token': token,
      'token': token,
    };

    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if (response.statusCode == 200) {
      return ManagerShift.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerApproveResponse> approveTimeSheets(
    String token,
    String data,
  ) async {
    var uri = Uri.parse('$baseURL/manager/approve-timesheet');
    var request = http.MultipartRequest("POST", uri);
    var headers = <String, String>{
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      'Token': token,
      'token': token,
    };
    request.fields["data"] = data;
    debugPrint(uri.toString());
    debugPrint(token);
    debugPrint(data);

    request.headers.addAll(headers);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    debugPrint(responseString);
    if (response.statusCode == 200) {
      return ManagerApproveResponse.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
