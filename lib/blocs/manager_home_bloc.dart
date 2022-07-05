import 'package:rxdart/rxdart.dart';

import '../model/dashboard_adapter.dart';
import '../model/manager_home_response.dart';
import '../resources/respository.dart';

class ManagaerHomeBloc {
  final _repo = Repository();
List<DashBoardAdapter> dashList=[];
  final _managerhome = PublishSubject<ManagerHomeResponse>();
  final _visibility = PublishSubject<bool>();

  Stream<bool> get visible => _visibility.stream;
  Stream<ManagerHomeResponse> get managerhomeStream => _managerhome.stream;

  fetchManagerHome(token) async {
    _visibility.add(true);
    dashList.clear();
    ManagerHomeResponse list = await _repo.fetchManagerHomeResponse(token);
    try{
      dashList.add(DashBoardAdapter(approved: list.response?.data?.summary?[0].approvedShiftDaily??"", pending: list.response?.data?.summary?[0].pendingShiftDaily??"", total: (int.parse(list.response?.data?.summary?[0].approvedShiftDaily??"0")+int.parse(list.response?.data?.summary?[0].pendingShiftDaily??"0")).toString()));
      dashList.add(DashBoardAdapter(approved: list.response?.data?.summary?[0].approvedShiftWeekly??"", pending: list.response?.data?.summary?[0].pendingShiftWeekly??"", total: (int.parse(list.response?.data?.summary?[0].approvedShiftWeekly??"0")+int.parse(list.response?.data?.summary?[0].pendingShiftWeekly??"0")).toString()));
      dashList.add(DashBoardAdapter(approved: list.response?.data?.summary?[0].approvedShiftMonthly??"", pending: list.response?.data?.summary?[0].pendingShiftMonthly??"", total: (int.parse(list.response?.data?.summary?[0].approvedShiftMonthly??"0")+int.parse(list.response?.data?.summary?[0].pendingShiftMonthly??"0")).toString()));
      _managerhome.sink.add(list);
    }catch(e){
      // _managerhome.sink.add(list);
    }
  _visibility.add(false);
  }

  dispose() {
    // _managerhome.close();
  }
}

final managerhomeBloc = ManagaerHomeBloc();
