import 'package:rxdart/rxdart.dart';

import '../model/remove_manager_schedule.dart';
import '../model/viewbooking_response.dart';
import '../resources/respository.dart';

class ShiftViewBookingBloc {
  final _repo = Repository();
  final _shiftViewBooking = PublishSubject<ManagerScheduleListResponse>();
  final _removeManagerSchedule =
      PublishSubject<RemoveManagerScheduleResponse>();

  Stream<ManagerScheduleListResponse> get allShift => _shiftViewBooking.stream;

  Stream<RemoveManagerScheduleResponse> get removeshift =>
      _removeManagerSchedule.stream;

  //get manager schedule by date
  fetchViewbooking(String token, String date) async {
    ManagerScheduleListResponse list =
        await _repo.fetchViewbooking(token, date);
    _shiftViewBooking.sink.add(list);
  }

  //remove manager schedule
  fetchRemoveManager(String token, String rowid) async {
    print(rowid);
    RemoveManagerScheduleResponse list =
        await _repo.fetchRemoveManager(token, rowid);
    _removeManagerSchedule.sink.add(list);
  }

  dispose() {
    _shiftViewBooking.close();
    _removeManagerSchedule.close();
  }
}

final viewbookingBloc = ShiftViewBookingBloc();
