import 'dart:io';

import 'package:rxdart/rxdart.dart';

import '../model/time_sheet_upload_respo.dart';
import '../model/user_complted_shift.dart';
import '../resources/respository.dart';

class ShiftCompletedBloc {
  final _repo = Repository();
  final _shiftComplete = PublishSubject<UserShoiftCompletedResponse>();
  final _uploadRespo= PublishSubject<TimeSheetUploadRespo>();

  Stream<UserShoiftCompletedResponse> get allShift => _shiftComplete.stream;
  Stream<TimeSheetUploadRespo> get uploadStatus => _uploadRespo.stream;

  fetchcomplete(String token) async {
    UserShoiftCompletedResponse list = await _repo.fetchComplete(token);
    _shiftComplete.sink.add(list);
  }

  dispose() {
    _shiftComplete.close();
  }

  uploadTimeSheet(String token, String ids, File file) async{
    TimeSheetUploadRespo data =  await _repo.uplodTimeSheet(token, ids, file);
    _uploadRespo.sink.add(data);
  }
}

final completeBloc = ShiftCompletedBloc();
