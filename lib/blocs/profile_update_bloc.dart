import 'dart:io';

import 'package:rxdart/rxdart.dart';
import '../model/user_documents_response.dart';
import '../model/user_get_response.dart';
import '../resources/respository.dart';

import '../db/database.dart';
import '../model/country_list.dart';
import '../model/gender_list.dart';
import '../model/update_profile_questn_respo.dart';
import '../model/user_profile_update.dart';
import '../model/visa_type_list.dart';

class ProfileBloc {
  final _repo = Repository();

  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;


  final _profileUser = PublishSubject<ProfileUpdateRespo>();
  final _getUser = PublishSubject<UserGetResponse>();
  final _documents = PublishSubject<UserDocumentsResponse>();
  final _questions = PublishSubject<ProfileQuestionResponse>();
  final _db = Db();

  List<String> genders = [];
  final _gender = PublishSubject<List<GenderList>>();

  Stream<List<GenderList>> get genderStream => _gender.stream;


  List<String> country = [];
  final _country = PublishSubject<List<CountryList>>();

  Stream<List<CountryList>> get countryStream => _country.stream;

  List<String> visatype = [];
  final _visatype = PublishSubject<List<VisaTypeList>>();

  Stream<List<VisaTypeList>> get visatypeStream => _visatype.stream;

  final _updateProfile = PublishSubject<void>();

  Stream<void>? get updateProfileSteam => _updateProfile.stream;

  getDropDownValues() async {
    var genderList = await _db.getGenderList();
    _gender.add(genderList);

    var country = await _db.getGetCountryList();
    _country.add(country);

    var visatypelist = await _db.getGetVisaTypeList();
    _visatype.add(visatypelist);
  }

  Stream<ProfileUpdateRespo> get profileStream => _profileUser.stream;

  Stream<UserGetResponse> get getProfileStream => _getUser.stream;

  Stream<UserDocumentsResponse> get userdocuments => _documents.stream;

  Stream<ProfileQuestionResponse> get getProfileQuestions => _questions.stream;


  getUserInfo(String token) async {
    _visibility.add(true);
    UserGetResponse response = await _repo.fetchUserInfo(token);

    _getUser.sink.add(response);
    _visibility.add(false);
  }

  ProfileUser(
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
    String bank_bic,
  ) async {
    _visibility.add(true);
    ProfileUpdateRespo respo = await _repo.ProfileUser(
        token,
        first_name,
        last_name,
        dob,
        gender,
        nationality,
        home_address,
        permission_to_work_in_ireland,
        visa_type,
        phone_number,
        email,
        pps_number,
        bank_iban,
        bank_bic);
    if(!_profileUser.isClosed)
      {
        _profileUser.sink.add(respo);
        _visibility.add(false);
      }

  }

  uploadUserDoc(
    String token, File  files,
    String type,
    String expiry_date,
  ) async {
    _visibility.add(true);
    UserDocumentsResponse respo = await _repo.uploadUserDoc(
      token,
      files,
      type,
      expiry_date,
    );
    _documents.sink.add(respo);
    _visibility.add(false);
  }



  profileQuestions(
      String token,
      String key,
      String value,
      ) async {
    _visibility.add(true);
    ProfileQuestionResponse respo = await _repo.fetchProfileQuestions(token, key,value);
    _questions.sink.add(respo);
    _visibility.add(false);
  }

  dispose() {
    // _profileUser.close();
    // _documents.close();
  }



}

final profileBloc = ProfileBloc();
