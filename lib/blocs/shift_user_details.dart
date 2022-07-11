import 'package:rxdart/rxdart.dart';
import '../model/user_get_shift_details.dart';
import '../resources/respository.dart';

class GetUserShiftDetailsBloc {
  String hospitalNumber = "";
  String? token;
  final _repo = Repository();
  final _userShiftDetails = PublishSubject<GetUserShiftDetailsResponse>();
  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;
  Stream<GetUserShiftDetailsResponse> get userShiftDetailsStream =>
      _userShiftDetails.stream;
  fetchGetUserShiftDetailsResponse(String shiftId) async {
    _visibility.add(true);
    GetUserShiftDetailsResponse resp =
        await _repo.fetchGetUserShiftDetailsResponse(token!, shiftId);
    _userShiftDetails.sink.add(resp);
    _visibility.add(false);
  }

  dispose() {
    _userShiftDetails.close();
  }
}

final userShiftDetailsBloc = GetUserShiftDetailsBloc();
