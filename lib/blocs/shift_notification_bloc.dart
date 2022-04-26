import 'package:rxdart/rxdart.dart';

import '../model/shift_list_response.dart';
import '../resources/respository.dart';

class ShiftNotificationBloc{
  final _repo = Repository();
  final _shiftNotify = PublishSubject<SliftListRepso>();
  Stream<SliftListRepso> get allShift => _shiftNotify.stream;
  fetchNotification() async {
    SliftListRepso list = await _repo.fetchNotification();
    _shiftNotify.sink.add(list);
  }
  dispose() {
    _shiftNotify.close();
  }
}

final  notificationBloc= ShiftNotificationBloc();
