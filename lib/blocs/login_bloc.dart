import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/login_response.dart';
import 'package:xpresshealthdev/resources/respository.dart';



class LoginBloc {
  final _repo = Repository();
  final _loginbloc = PublishSubject<LoginUserRespo>();
  Stream<LoginUserRespo> get loginStream => _loginbloc.stream;
  fetchLogin(String username,String  password,String user_type) async {

    LoginUserRespo? respo = await _repo.fetchLogin(username, password,user_type);
    if(null!=respo)
      {
        _loginbloc.sink.add(respo);
      }else{
      _loginbloc.sink.add(LoginUserRespo());
    }

  }

  dispose() {
    _loginbloc.close();
  }
}

final loginBloc = LoginBloc();


