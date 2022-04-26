import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_get_shift_details.dart';
import 'package:xpresshealthdev/resources/respository.dart';

class GetUserShiftDetailsBloc {
  final _repo = Repository();
  final _usershiftdetails = PublishSubject<GetUserShiftDetailsResponse>();

  Stream<GetUserShiftDetailsResponse> get usershiftdetailsStream =>
      _usershiftdetails.stream;

  fetchGetUserShiftDetailsResponse(String token, String shift_id) async {
    GetUserShiftDetailsResponse respo =
        await _repo.fetchGetUserShiftDetailsResponse(token, shift_id);
    _usershiftdetails.sink.add(respo);
  }

  dispose() {
    _usershiftdetails.close();
  }
}

final usershiftdetailsBloc = GetUserShiftDetailsBloc();
