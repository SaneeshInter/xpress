import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../model/user_view_request_response.dart';

import '../model/user_cancel_jobrequest.dart';
import '../model/user_working_hours.dart';
import '../resources/respository.dart';
import '../utils/utils.dart';

class ShiftConfirmedBloc {
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int working_hours = 0;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  var token;
  final _repo = Repository();
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;
  final workingHours = PublishSubject<int>();

  Stream<int> get workTime => workingHours.stream;

  final _usercanceljob = PublishSubject<UserCancelJobRequestResponse>();
  final _userworkinghours = PublishSubject<UserWorkingHoursResponse>();
  final _viewrequest = PublishSubject<UserViewRequestResponse>();

  Stream<UserViewRequestResponse> get viewrequest => _viewrequest.stream;

  Stream<UserCancelJobRequestResponse> get usercanceljobrequest => _usercanceljob.stream;

  Stream<UserWorkingHoursResponse> get userworkinghours => _userworkinghours.stream;

  fetchUserViewRequest(String token) async {
    _visibility.add(true);
    UserViewRequestResponse list = await _repo.fetchUserViewRequestResponse(token);
    if (!_viewrequest.isClosed) {
      _viewrequest.sink.add(list);
      _visibility.add(false);
    }
  }

  userCancelJob(String token, String job_request_row_id) async {
    _visibility.add(true);
    UserCancelJobRequestResponse list = await _repo.cancelJobRequest(token, job_request_row_id);
    if (!_usercanceljob.isClosed) {
      _visibility.add(false);
      _usercanceljob.sink.add(list);
    }
  }

  fetchUserWorkingHours(String token, String shift_id, String start_time, String end_time, String working_hours) async {

    _visibility.add(true);
    var timeFrom = convert12hrTo24hr(start_time);
    var timeTo = convert12hrTo24hr(end_time);
    UserWorkingHoursResponse list = await _repo.AddUserWorking(token, shift_id, timeFrom, timeTo, working_hours);
    if (!_userworkinghours.isClosed) {
      _visibility.add(false);
      _userworkinghours.sink.add(list);
    }

  }

  Future<void> checkAndUpdateTimeDiffernce(String dateTo, String dateFrom) async {

    if (dateTo.isNotEmpty && dateFrom.isNotEmpty) {
      DateTime date = DateFormat.jm().parse(dateFrom);
      DateTime date1 = DateFormat.jm().parse(dateTo);
      var time1 = DateFormat("HH:mm").format(date);
      var time2 = DateFormat("HH:mm").format(date1);
      var timeDiffrence = await getDifference(time1, time2);
      working_hours = timeDiffrence;
      workingHours.add(working_hours);
    }

  }

  dispose() {

    _viewrequest.close();
    _usercanceljob.close();
    _userworkinghours.close();

  }
}

final confirmBloc = ShiftConfirmedBloc();
