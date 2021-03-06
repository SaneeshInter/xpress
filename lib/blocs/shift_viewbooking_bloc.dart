import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../model/remove_manager_schedule.dart';
import '../model/viewbooking_response.dart';
import '../resources/respository.dart';

class ShiftViewBookingBloc {
  final _repo = Repository();
  final _shiftViewBooking = PublishSubject<ManagerScheduleListResponse>();
  final _removeManagerSchedule =
      PublishSubject<RemoveManagerScheduleResponse>();


  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerScheduleListResponse> get allShifts => _shiftViewBooking.stream;

  Stream<RemoveManagerScheduleResponse> get removeShift =>
      _removeManagerSchedule.stream;

  //get manager schedule by date
  fetchViewBooking(String token, String date) async {
    _visibility.add(true);
    ManagerScheduleListResponse list =
        await _repo.fetchViewbooking(token, date);
    _shiftViewBooking.sink.add(list);
    _visibility.add(false);
  }

  //remove manager schedule
  fetchRemoveManager(String token, String rowId) async {
    _visibility.add(true);
    debugPrint(rowId);
    RemoveManagerScheduleResponse list =
        await _repo.fetchRemoveManager(token, rowId);
    _removeManagerSchedule.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    _shiftViewBooking.close();
    _removeManagerSchedule.close();
  }
}

final viewBookingBloc = ShiftViewBookingBloc();
