import 'package:rxdart/rxdart.dart';
import 'package:xpresshealthdev/resources/respository.dart';

import '../model/user_shift_calender.dart';
import '../model/utility_respo.dart';

class ShiftCalendarBloc{
    final _repo = Repository();
    final _shiftcalender = PublishSubject<UserGetScheduleByYear>();

    Stream<UserGetScheduleByYear> get shiftcalendar => _shiftcalender.stream;

    userGetScheduleByYear (String token, String year) async {
        UserGetScheduleByYear respo = await _repo.fetchuserscheduleyear(token, year);
        _shiftcalender.sink.add(respo);
    }

    dispose() {
        _shiftcalender.close();
    }
}
final shiftcalenderBloc = ShiftCalendarBloc();
