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
  var token;

  var profileImage = "";
  var genderId = 1;
  var nationalityId = 1;
  var visatypeId = 1;
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

  List<String> visaType = [];
  final _visaType = PublishSubject<List<VisaTypeList>>();

  Stream<List<VisaTypeList>> get visaTypeStream => _visaType.stream;

  final _updateProfile = PublishSubject<void>();

  Stream<void>? get updateProfileSteam => _updateProfile.stream;

  getDropDownValues() async {
    var genderList = await _db.getGenderList();
    _gender.add(genderList);

    var country = await _db.getGetCountryList();
    _country.add(country);

    var visaTypeList = await _db.getGetVisaTypeList();
    _visaType.add(visaTypeList);
  }

  Stream<ProfileUpdateRespo> get profileStream => _profileUser.stream;

  Stream<UserGetResponse> get getProfileStream => _getUser.stream;

  Stream<UserDocumentsResponse> get userdocuments => _documents.stream;

  Stream<ProfileQuestionResponse> get getProfileQuestions => _questions.stream;

  getUserInfo() async {
    _visibility.add(true);
    UserGetResponse response = await _repo.fetchUserInfo(token);
    _getUser.sink.add(response);
    _visibility.add(false);
  }

  ProfileUser(
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
    String bankBic,
  ) async {
    _visibility.add(true);
    ProfileUpdateRespo resp = await _repo.ProfileUser(token, firstName, lastName, dob, gender, nationality, homeAddress,
        permissionToWorkInIreland, visaType, phoneNumber, email, ppsNumber, bankIban, bankBic);
    if (!_profileUser.isClosed) {
      _profileUser.sink.add(resp);
      _visibility.add(false);
    }
  }

  uploadUserDoc(
    String token,
    File files,
    String type,
    String expiryDate,
  ) async {
    _visibility.add(true);
    UserDocumentsResponse resp = await _repo.uploadUserDoc(
      token,
      files,
      type,
      expiryDate,
    );
    _documents.sink.add(resp);
    _visibility.add(false);
  }

  profileQuestions(
    String token,
    String key,
    String value,
  ) async {
    _visibility.add(true);
    ProfileQuestionResponse resp = await _repo.fetchProfileQuestions(token, key, value);
    _questions.sink.add(resp);
    _visibility.add(false);
  }

  dispose() {
    // _profileUser.close();
    // _documents.close();
  }
}

final profileBloc = ProfileBloc();
