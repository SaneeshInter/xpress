import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/login_response.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/shift_list_response.dart';

class LoginBloc {
  final _repo = Repository();
  final _loginbloc = PublishSubject<LoginUserRespo>();
  Stream<LoginUserRespo> get loginStream => _loginbloc.stream;
  fetchLogin(String username,String  password) async {
    LoginUserRespo respo = await _repo.fetchLogin(username, password);
    _loginbloc.sink.add(respo);
  }

  dispose() {
    _loginbloc.close();
  }
}

final loginBloc = LoginBloc();


