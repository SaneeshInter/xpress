import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/accept_job_request.dart';
import '../model/manager_view_request.dart';
import '../model/shift_list_response.dart';

class ManagerViewRequestBloc {
  final _repo = Repository();
  final _managerviewrequest = PublishSubject<ManagerViewRequestResponse>();
  final _shiftAcceptJobRequest = PublishSubject<AcceptJobRequestResponse>();
  Stream<ManagerViewRequestResponse> get managerviewrequest => _managerviewrequest.stream;
  Stream<AcceptJobRequestResponse> get acceptjobrequest => _shiftAcceptJobRequest.stream;
  //view booking
  fetchManagerViewRequest(String token,String shift_id ) async {
    ManagerViewRequestResponse respo = await _repo.fetchManagerViewRequest(token, shift_id);
    _managerviewrequest.sink.add(respo);
  }
  //acceptjob
  fetchAcceptJobRequestResponse(String token, String job_request_row_id,) async {
    AcceptJobRequestResponse list = await _repo.fetchAcceptJobRequestResponse( token, job_request_row_id);
    _shiftAcceptJobRequest.sink.add(list);
  }

  dispose() {
    _managerviewrequest.close();
    _shiftAcceptJobRequest.close();
  }
}

final managerviewrequestBloc = ManagerViewRequestBloc();


