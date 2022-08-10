
import 'package:rxdart/rxdart.dart';
import '../model/accept_job_request.dart';
import '../model/account_logout.dart';
import '../resources/respository.dart';

class AccountLogoutBLoc {
  var token;
  var user_type = "";
  final _repo = Repository();

  final _accountLogOut = PublishSubject<AccountLogOutResponse>();

  Stream<AccountLogOutResponse> get accountLogoutStream =>
      _accountLogOut.stream;

  fetchAcccountLogOut(String token, String user_type) async {
    AccountLogOutResponse list =
    await _repo.fetchAccountLogout(token, user_type);
    _accountLogOut.sink.add(list);
  }

  dispose() {
    _accountLogOut.close();
  }
}

final accountlogouttBloc = AccountLogoutBLoc();
