import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_get_shift_details.dart';
import 'package:xpresshealthdev/resources/respository.dart';

class GetUserShiftDetailsBloc {
  final _repo = Repository();
  final _usershiftdetails = PublishSubject<GetUserShiftDetailsResponse>();
  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;
  Stream<GetUserShiftDetailsResponse> get usershiftdetailsStream =>
      _usershiftdetails.stream;
  fetchGetUserShiftDetailsResponse(String token, String shift_id) async {
    _visibility.add(true);
    GetUserShiftDetailsResponse respo =
        await _repo.fetchGetUserShiftDetailsResponse(token, shift_id);
    _usershiftdetails.sink.add(respo);
    _visibility.add(false);
  }

  dispose() {
    _usershiftdetails.close();
  }
}

final usershiftdetailsBloc = GetUserShiftDetailsBloc();
