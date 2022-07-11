import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../model/user_view_request_response.dart';

import '../model/user_cancel_jobrequest.dart';
import '../model/user_working_hours.dart';
import '../resources/respository.dart';
import '../utils/utils.dart';

class ShiftConfirmedBloc {
  int devicePixelRatio = 4;
  int perPageItem = 4;
  String workingHour = "0";
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  var token;
  final _repo = Repository();
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;
  final workingHours = PublishSubject<String>();

  Stream<String> get workTime => workingHours.stream;

  final _userCancelJob = PublishSubject<UserCancelJobRequestResponse>();
  final _userWorkingHours = PublishSubject<UserWorkingHoursResponse>();
  final _viewRequest = PublishSubject<UserViewRequestResponse>();

  Stream<UserViewRequestResponse> get viewRequest => _viewRequest.stream;

  Stream<UserCancelJobRequestResponse> get userCancelJobRequest => _userCancelJob.stream;

  Stream<UserWorkingHoursResponse> get userWorkingHours => _userWorkingHours.stream;

  fetchUserViewRequest(String token) async {
    _visibility.add(true);
    UserViewRequestResponse list = await _repo.fetchUserViewRequestResponse(token);
    if (!_viewRequest.isClosed) {
      _viewRequest.sink.add(list);
      _visibility.add(false);
    }
  }

  userCancelJob(String token, String jobRequestRowId) async {
    _visibility.add(true);
    UserCancelJobRequestResponse list = await _repo.cancelJobRequest(token, jobRequestRowId);
    if (!_userCancelJob.isClosed) {
      _visibility.add(false);
      _userCancelJob.sink.add(list);
    }
  }

  fetchUserWorkingHours(String token, String shiftId, String startTime, String endTime, String workingHours) async {

    _visibility.add(true);
    var timeFrom = convert12hrTo24hr(startTime);
    var timeTo = convert12hrTo24hr(endTime);
    UserWorkingHoursResponse list = await _repo.AddUserWorking(token, shiftId, timeFrom, timeTo, workingHours);
    if (!_userWorkingHours.isClosed) {
      _visibility.add(false);
      _userWorkingHours.sink.add(list);
    }

  }

  Future<void> checkAndUpdateTimeDifference(String dateTo, String dateFrom) async {

    if (dateTo.isNotEmpty && dateFrom.isNotEmpty) {
      DateTime date = DateFormat.jm().parse(dateFrom);
      DateTime date1 = DateFormat.jm().parse(dateTo);
      workingHour = getDiffrenceBetweenDates(date,date1);
      workingHours.add(workingHour);
      // if (dateFrom.compareTo(dateTo) < 0) {
      //   var time1 = DateFormat("HH:mm").format(date);
      //   var time2 = DateFormat("HH:mm").format(date1);
      //
      //   getDiffrenceBetweenDates(date,date1);
      //
      //
      //   var timeDiffrence = await getDifference(time1, time2);
      //
      // }else{
      //
      //   var time1 = DateFormat("HH:mm").format(date);
      //   var time2 = DateFormat("HH:mm").format(date1);
      //   var timeDiffrence = await getDifference(time1, time2);
      //   working_hours = timeDiffrence;
      //   workingHours.add(working_hours);
      // }
    }

  }
  // Future<void> checkAndUpdateTimeDiffernce(String dateTo, String dateFrom) async {
  //
  //   if (dateTo.isNotEmpty && dateFrom.isNotEmpty) {
  //     DateTime date = DateFormat.jm().parse(dateFrom);
  //     DateTime date1 = DateFormat.jm().parse(dateTo);
  //
  //
  //     if (dateFrom.compareTo(dateTo) < 0) {
  //       var time1 = DateFormat("HH:mm").format(date);
  //       var time2 = DateFormat("HH:mm").format(date1);
  //       var timeDiffrence = await getDifference(time1, time2);
  //       working_hours = timeDiffrence;
  //       workingHours.add(working_hours);
  //     }else{
  //
  //       var time1 = DateFormat("HH:mm").format(date);
  //       var time2 = DateFormat("HH:mm").format(date1);
  //       var timeDiffrence = await getDifference(time1, time2);
  //       working_hours = timeDiffrence;
  //       workingHours.add(working_hours);
  //     }
  //   }
  //
  // }

  dispose() {

    // _viewrequest.close();
    // _usercanceljob.close();
    // _userworkinghours.close();

  }
}

final confirmBloc = ShiftConfirmedBloc();
