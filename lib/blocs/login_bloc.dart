import 'package:rxdart/rxdart.dart';
import '../model/login_response.dart';
import '../resources/respository.dart';



class LoginBloc {
  final _repo = Repository();
  final _loginbloc = PublishSubject<LoginUserRespo>();


  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;





  Stream<LoginUserRespo> get loginStream => _loginbloc.stream;
  fetchLogin(String username,String  password,String user_type) async {
    _visibility.add(true);
    LoginUserRespo? respo = await _repo.fetchLogin(username, password,user_type);
    if(null!=respo)
      {
        _visibility.add(false);
        _loginbloc.sink.add(respo);
      }else{
      _visibility.add(false);
      _loginbloc.sink.add(LoginUserRespo());

    }
  }
  dispose() {
    // _loginbloc.close();
  }
}

final loginBloc = LoginBloc();


