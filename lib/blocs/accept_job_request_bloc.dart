import 'package:/rxdart/rxdart.dart';

import '../model/accept_job_request.dart';
import '../resources/respository.dart';

class AcceptJobRequestBloc {
  final _repo = Repository();

  final _shiftAcceptJobRequest = PublishSubject<AcceptJobRequestResponse>();

  Stream<AcceptJobRequestResponse> get acceptjobrequest =>
      _shiftAcceptJobRequest.stream;

  fetchAcceptJobRequestResponse(
    String token,
    String job_request_row_id,
  ) async {
    AcceptJobRequestResponse list =
        await _repo.fetchAcceptJobRequestResponse(token, job_request_row_id);
    _shiftAcceptJobRequest.sink.add(list);
  }

  dispose() {
    _shiftAcceptJobRequest.close();
  }
}

final acceptjobrequestBloc = AcceptJobRequestBloc();
