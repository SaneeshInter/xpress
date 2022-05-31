import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/model/user_home_response.dart';

import '../resources/respository.dart';

class ShiftHomepageBloc {
  final _repo = Repository();

  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;

  final _userhome = PublishSubject<UserHomeResponse>();

  Stream<UserHomeResponse> get userhomeStream => _userhome.stream;

  fetchUserHomepage(token) async {
    _visibility.add(true);
    UserHomeResponse list = await _repo.fetchUserHomeResponse(token);
    if (!_userhome.isClosed) {
      _visibility.add(false);
      _userhome.sink.add(list);
    }
  }

  dispose() {
    _userhome.close();
  }
}

final homepageBloc = ShiftHomepageBloc();
