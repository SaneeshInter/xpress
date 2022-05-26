import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_view_request_response.dart';


import '../model/shift_list_response.dart';
import '../model/user_cancel_jobrequest.dart';

import '../model/user_working_hours.dart';
import '../resources/respository.dart';

class ShiftConfirmedBloc{
  final _repo = Repository();
  final   _viewrequest=PublishSubject<UserViewRequestResponse>();
  final   _usercanceljob=PublishSubject<UserCancelJobRequestResponse>();
  final   _userworkinghours=PublishSubject<UserWorkingHoursResponse>();


  Stream<UserViewRequestResponse> get viewrequest => _viewrequest.stream;
  Stream<UserCancelJobRequestResponse> get usercanceljobrequest => _usercanceljob.stream;

  Stream<UserWorkingHoursResponse> get userworkinghours => _userworkinghours.stream;

  fetchUserViewRequest(String token) async {
    UserViewRequestResponse list = await _repo.fetchUserViewRequestResponse(token);
    _viewrequest.sink.add(list);
  }


   UserCancelJobResponse( String token, String job_request_row_id) async {
    UserCancelJobRequestResponse list = await _repo.UserCancelJobResponse(token,job_request_row_id);
    _usercanceljob.sink.add(list);
  }


fetchUserWorkingHours(String token, String shift_id,String start_time,String end_time,String working_hours) async {
    print("working");
    print(working_hours);
  UserWorkingHoursResponse list = await _repo.AddUserWorking(token,  shift_id, start_time,end_time,working_hours);
  _userworkinghours.sink.add(list);
  }

  dispose() {
    _viewrequest.close();
    _usercanceljob.close();
    _userworkinghours.close();
  }
}


final  confirmBloc= ShiftConfirmedBloc();
