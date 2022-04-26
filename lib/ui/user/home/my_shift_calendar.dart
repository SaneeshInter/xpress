import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors_util.dart';
import '../underdev/event_tap.dart';

class FindshiftCalendar extends StatefulWidget {
  const FindshiftCalendar({Key? key}) : super(key: key);

  @override
  _FindshiftState createState() => _FindshiftState();
}

class _FindshiftState extends State<FindshiftCalendar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int devicePixelRatio = 3;
  int perPageItem = 3;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  var selected = 0;
  var itemSelected = 0;
  late PageController pageController;

  final ScrollController _controller = ScrollController();

  @override
  void didUpdateWidget(covariant FindshiftCalendar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    pageCount = 3;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: HexColor("#ffffff"),
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/images/icon/menu.svg',
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
            //change your color here
          ),
          backgroundColor: HexColor("#ffffff"),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/icon/logo.svg',
                    fit: BoxFit.contain,
                    height: 30,
                    width: 40,
                  )),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  'assets/images/icon/searchicon.svg'), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
            ),
          ],
        ),
        //backgroundColor: Constants.colors[9],

        body: bookingList(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: widget.color,
      alignment: Alignment.center,
    );
  }
}

Widget bookingList() {
  return Container(
    child: MyShiftCalender(),
  );
}
