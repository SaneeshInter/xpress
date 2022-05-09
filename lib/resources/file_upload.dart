import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/time_sheet_upload_respo.dart';
import '../model/user_documents_response.dart';

class ApiFileProvider {
  String BASE_URL = "https://intersmarthosting.in/DEV/ExpressHealth/api";






  Future<TimeSheetUploadRespo>   asyncFileUpload(String token, String ids, File file) async {
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



  Future<UserDocumentsResponse>uploadUserDocuments( String token, File files, String type, String expiry_date) async {
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


  // Future<UserDocumentsResponse> uploadUserDocuments(
  //     String token, File files, String type, String expiry_date) async {
  //   var uri = Uri.parse(BASE_URL + "/account/upload-user-documents");
  //   final response = await client.post(uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'token': token,
  //       },
  //       body: jsonEncode(<String, String>{
  //         'files': files,
  //         'type': type,
  //         'expiry_date': expiry_date,
  //       }));
  //
  //   print("UPLOAD USER DOCUMENTS" + token);
  //
  //   print(jsonEncode(<String, String>{
  //     'files': files,
  //     'type': type,
  //     'expiry_date': expiry_date,
  //   }).toString());
  //   print(response.body);
  //
  //   if (response.statusCode == 200) {
  //     return UserDocumentsResponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }



}
