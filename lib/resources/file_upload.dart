import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/manager_response.dart';
import '../model/time_sheet_upload_respo.dart';
import '../model/user_documents_response.dart';

class ApiFileProvider {
  String BASE_URL = "https://intersmarthosting.in/DEV/ExpressHealth/api";

  Future<TimeSheetUploadRespo> asyncFileUpload(
      String token, String ids, File file) async {
    var uri = Uri.parse(BASE_URL + '/user/add-time-sheet');
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
      String token, File files, String type, String expiry_date) async {
    var uri = Uri.parse(BASE_URL + '/account/upload-user-documents');
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
    print(uri.toString());
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
    print(response);
    print(responseString);

    if (response.statusCode == 200) {
      return UserDocumentsResponse.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ManagerShift> CreateShiftManagers(
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
    var uri = Uri.parse(BASE_URL + '/manager/add-schedule');

    if (row_id != -1) {
      uri = Uri.parse(BASE_URL + '/manager/edit-schedule');
    }
    var request = http.MultipartRequest("POST", uri);

    request.fields["type"] = type;
    if (row_id != -1) {
      print("edit");
      request.fields["row_id"] = row_id.toString();
    }
    request.fields["category"] = category;
    request.fields["user_type"] = user_type;
    request.fields["job_title"] = job_title;
    request.fields["hospital"] = hospital;
    request.fields["date"] = date;
    request.fields["time_from"] = time_from;
    request.fields["time_to"] = time_to;
    request.fields["job_details"] = job_details;
    request.fields["price"] = price;
    request.fields["allowances"] = allowances;
    request.fields["assigned_to"] = "";
    request.fields["shift"] = shift;

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
    print("response.statusCode");
    print(response.statusCode);
    print("request.toString()");
    print(request.toString());
    print(response);
    print(responseString);
    if (response.statusCode == 200) {
      return ManagerShift.fromJson(json.decode(responseString));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
