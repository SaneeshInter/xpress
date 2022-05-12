import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/manager_shift_calendar_respo.dart';
import '../model/user_shift_calender.dart';
import '../model/utility_respo.dart';

class ManagerShiftCalendarBloc{
  final _repo = Repository();
  final _getshiftcalendar = PublishSubject<ManagerGetScheduleByYear>();

  Stream<ManagerGetScheduleByYear> get managercalendar => _getshiftcalendar.stream;

  managerGetScheduleByYear (String token, String year) async {
    ManagerGetScheduleByYear respo = await _repo.fetchmanagerscheduleyear(token, year);
    _getshiftcalendar.sink.add(respo);
  }

  dispose() {
    _getshiftcalendar.close();
  }
}
final managercalendarBloc = ManagerShiftCalendarBloc();
