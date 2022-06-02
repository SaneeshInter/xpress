import 'dart:io';

import 'package:rxdart/rxdart.dart';

import '../model/time_sheet_upload_respo.dart';
import '../model/user_complted_shift.dart';
import '../resources/respository.dart';

class ShiftCompletedBloc {
  final _repo = Repository();

  bool visibility = false;
  bool buttonVisibility = false;
  var token;
  var image;
  List<String> list = [];

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;




  final _shiftComplete = PublishSubject<UserShoiftCompletedResponse>();
  final _uploadRespo= PublishSubject<TimeSheetUploadRespo>();

  Stream<UserShoiftCompletedResponse> get allShift => _shiftComplete.stream;
  Stream<TimeSheetUploadRespo> get uploadStatus => _uploadRespo.stream;

  fetchcomplete() async {
    _visibility.add(true);
    UserShoiftCompletedResponse list = await _repo.fetchComplete(token);
    if (!_shiftComplete.isClosed) {
      _shiftComplete.sink.add(list);
      _visibility.add(false);
    }
  }

  dispose() {
    _shiftComplete.close();
  }

  uploadTimeSheet(String ids, File file) async{
    _visibility.add(true);
    TimeSheetUploadRespo data =  await _repo.uplodTimeSheet(token, ids, file);
    _uploadRespo.sink.add(data);
    _visibility.add(false);
  }
}

final completeBloc = ShiftCompletedBloc();
