import 'package:rxdart/rxdart.dart';

import '../model/user_notification_model.dart';
import '../resources/respository.dart';
import '../resources/token_provider.dart';

class ManagerShiftNotificationBloc{
  final _repo = Repository();
  final _shiftNotify = PublishSubject<UserNotificationModel>();
  Stream<UserNotificationModel> get allShift => _shiftNotify.stream;
  fetchNotification() async {
    String  token = await TokenProvider().getToken()??"";
    UserNotificationModel list = await _repo.fetchManagerNotification(token);
    _shiftNotify.sink.add(list);
  }
  dispose() {
    _shiftNotify.close();
  }
}

final  managerNotificationBloc= ManagerShiftNotificationBloc();