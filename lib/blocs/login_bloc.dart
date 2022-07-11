import 'package:rxdart/rxdart.dart';
import '../model/login_response.dart';
import '../resources/respository.dart';



class LoginBloc {
  final _repo = Repository();
  final _loginBloc = PublishSubject<LoginUserRespo>();
  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;
  Stream<LoginUserRespo> get loginStream => _loginBloc.stream;
  fetchLogin(String username,String  password,String userType,String deviceId) async {
    _visibility.add(true);

    LoginUserRespo? repo = await _repo.fetchLogin(username, password,userType, deviceId);
    if(null!=repo)
      {
        _visibility.add(false);
        _loginBloc.sink.add(repo);
      }else{
      _visibility.add(false);
      _loginBloc.sink.add(LoginUserRespo());

    }
  }
  dispose() {
    // _loginbloc.close();
  }
}

final loginBloc = LoginBloc();


