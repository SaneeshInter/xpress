import 'package:rxdart/rxdart.dart';
import '../model/user_get_shift_details.dart';
import '../resources/respository.dart';

class GetUserShiftDetailsBloc {
  String hospitalNumber = "";
  String? token;
  final _repo = Repository();
  final _usershiftdetails = PublishSubject<GetUserShiftDetailsResponse>();
  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;
  Stream<GetUserShiftDetailsResponse> get usershiftdetailsStream =>
      _usershiftdetails.stream;
  fetchGetUserShiftDetailsResponse(String shift_id) async {
    _visibility.add(true);
    GetUserShiftDetailsResponse respo =
        await _repo.fetchGetUserShiftDetailsResponse(token!, shift_id);
    _usershiftdetails.sink.add(respo);
    _visibility.add(false);
  }

  dispose() {
    _usershiftdetails.close();
  }
}

final usershiftdetailsBloc = GetUserShiftDetailsBloc();
