import 'package:rxdart/rxdart.dart';

import '../model/manager_home_response.dart';
import '../resources/respository.dart';

class ManagaerHomeBloc {
  final _repo = Repository();
  final _managerhome = PublishSubject<ManagerHomeResponse>();

  Stream<ManagerHomeResponse> get managerhomeStream => _managerhome.stream;

  fetchManagerHome(token) async {
    ManagerHomeResponse list = await _repo.fetchManagerHomeResponse(token);
    _managerhome.sink.add(list);
  }

  dispose() {
    _managerhome.close();
  }
}

final managerhomeBloc = ManagaerHomeBloc();
