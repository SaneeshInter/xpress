import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_home_response.dart';

import '../model/shift_list_response.dart';
import '../resources/respository.dart';

class ShiftHomepageBloc{
  final _repo = Repository();

  final _userhome= PublishSubject<UserHomeResponse>();


  Stream<UserHomeResponse> get userhomeStream => _userhome.stream;
  fetchUserHomepage(token) async {
    UserHomeResponse list = await _repo.fetchUserHomeResponse(token);
    if(!_userhome.isClosed)
      {
        _userhome.sink.add(list);
      }

  }






  dispose() {
    _userhome.close();
  }
}

final  homepageBloc= ShiftHomepageBloc();


