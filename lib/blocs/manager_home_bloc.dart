import 'package:rxdart/rxdart.dart';

import '../model/manager_home_response.dart';
import '../resources/respository.dart';

class ManagaerHomeBloc {
  final _repo = Repository();
  final _managerhome = PublishSubject<ManagerHomeResponse>();

  final _visibility = PublishSubject<bool>();
  Stream<bool> get visible => _visibility.stream;

  Stream<ManagerHomeResponse> get managerhomeStream => _managerhome.stream;

  fetchManagerHome(token) async {  _visibility.add(true);
    ManagerHomeResponse list = await _repo.fetchManagerHomeResponse(token);
    _managerhome.sink.add(list);
  _visibility.add(false);
  }

  dispose() {
    _managerhome.close();
  }
}

final managerhomeBloc = ManagaerHomeBloc();
