import 'package:rxdart/rxdart.dart';

import '../model/accept_job_request.dart';
import '../model/manager_view_request.dart';
import '../resources/respository.dart';

class ManagerViewRequestBloc {
  final _repo = Repository();
  final _managerViewRequest = PublishSubject<ManagerViewRequestResponse>();
  final _shiftAcceptJobRequest = PublishSubject<AcceptJobRequestResponse>();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerViewRequestResponse> get managerViewRequest =>
      _managerViewRequest.stream;

  Stream<AcceptJobRequestResponse> get acceptJobRequest =>
      _shiftAcceptJobRequest.stream;

  //view booking
  fetchManagerViewRequest(String token, String shiftId) async {
    _visibility.add(true);
    ManagerViewRequestResponse resp =
        await _repo.fetchManagerViewRequest(token, shiftId);
    _managerViewRequest.sink.add(resp);
    _visibility.add(false);
  }

  //acceptor
  fetchAcceptJobRequestResponse(
    String token,
    String jobRequestRowId,
  ) async {
    _visibility.add(true);
    AcceptJobRequestResponse list =
        await _repo.fetchAcceptJobRequestResponse(token, jobRequestRowId);
    _shiftAcceptJobRequest.sink.add(list);
    _visibility.add(false);
  }

  dispose() {
    // _managerViewRequest.close();
    // _shiftAcceptJobRequest.close();
  }
}

final managerViewRequestBloc = ManagerViewRequestBloc();
