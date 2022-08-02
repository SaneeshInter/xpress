import 'package:flutter/material.dart';
import 'package:xpresshealthdev/Constants/strings.dart';
import 'package:xpresshealthdev/ui/user/home/profile_screen.dart';

import '../../../utils/constants.dart';
import '../../widgets/manager/confirmed_list_widget.dart';
import 'completed_shift_screen.dart';

class TimeSheetTabView extends StatefulWidget {
  const TimeSheetTabView({Key? key}) : super(key: key);

  @override
  State<TimeSheetTabView> createState() => _TimeSheetTabViewState();
}

class _TimeSheetTabViewState extends State<TimeSheetTabView> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colors[9],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          color: Constants.colors[0],
          child: TabBar(unselectedLabelColor: Colors.black, indicatorSize: TabBarIndicatorSize.tab, labelColor: Colors.black, controller: _tabController, tabs: const [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(Txt.add_working_hrs,style: TextStyle(fontSize: 13),),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(Txt.completed_timesheets,style: TextStyle(fontSize: 13),),
              ),
            ),
          ]),
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        ConfirmedListWidget(),
        CompletedShiftScreen(),
      ]),
    );
  }
}
