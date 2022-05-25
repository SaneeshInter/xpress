import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/blocs/shift_confirmed_bloc.dart';
import 'package:xpresshealthdev/model/filter_booking_list.dart';
import 'package:xpresshealthdev/model/user_view_request_response.dart';

import '../../../Constants/strings.dart';
import '../../../resources/token_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../utils/validator.dart';
import '../../Widgets/buttons/submit_small.dart';
import '../../Widgets/my_booking_list_widget.dart';
import '../../error/ConnectionFailedScreen.dart';
import '../../widgets/input_text.dart';
import '../../widgets/loading_widget.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  _HomeScreentate createState() => _HomeScreentate();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool visibility = false;
var token;

class _HomeScreentate extends State<MyBookingScreen> {
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
  void didUpdateWidget(covariant MyBookingScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void canceljob(Items items) {
    if (items is Items) {
      setState(() {
        visibility = true;
      });

      Items data = items;
      confirmBloc.UserCancelJobResponse(token, data.rowId.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    confirmBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    getDataitems();
    observe();
    pageController = PageController(initialPage: 0);
    pageCount = 3;
  }

  Future getDataitems() async {
    token = await TokenProvider().getToken();
    if (null != token) {
      if (await isNetworkAvailable()) {
        setState(() {
          visibility = true;
        });
        confirmBloc.fetchUserViewRequest(token);
      } else {
        showInternetNotAvailable();
      }
    }
  }

  Future<void> showInternetNotAvailable() async {
    int respo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
    );
    if (respo == 1) {
      getDataitems();
    }
  }

  void observe() {
    confirmBloc.usercanceljobrequest.listen((event) {
      setState(() {
        visibility = false;
      });
      String? message = event.response?.status?.statusMessage;
      getDataitems();
      showAlertDialoge(context, message: message!, title: "Cancel");
    });
    confirmBloc.userworkinghours.listen((event) {
      setState(() {
        visibility = false;
      });
      String? message = event.response?.status?.statusMessage;
      getDataitems();
      showAlertDialoge(context, message: message!, title: "Working hours");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Constants.colors[9],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              getDataitems();
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.refresh),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: Container(
              color: Constants.colors[0],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Requested Shift"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Confirmed Shift"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Completed Shift"),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          body: StreamBuilder(
              stream: confirmBloc.viewrequest,
              builder: (BuildContext context,
                  AsyncSnapshot<UserViewRequestResponse> snapshot) {
                if (snapshot.hasData) {
                  return TabBarView(children: [
                    bookingList(0, snapshot),
                    bookingList(1, snapshot),
                    bookingList(2, snapshot),
                  ]);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(
                  child: Visibility(
                    child: Container(
                      width: 100.w,
                      height: 80.h,
                      child: const Center(
                        child: LoadingWidget(),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget bookingList(
      int position, AsyncSnapshot<UserViewRequestResponse> snapshot) {
    return Column(children: [buildList(snapshot, position)]);
  }

  Future<void> showTimeUpdateAlert(BuildContext context, Items item) async {
    TextEditingController dateFrom = new TextEditingController();
    TextEditingController dateTo = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 90.w,
                    color: Colors.red,
                    child: Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 11.w,
                                color: Constants.colors[20],
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Add Timesheet",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "SFProMedium",
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 50),
                                            child: SvgPicture.asset(
                                              "assets/images/icon/close.svg",
                                              height: 3.w,
                                              width: 3.w,
                                              color: Constants.colors[0],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Start Time",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Constants.colors[22],
                                              fontSize: 11.sp,
                                              fontFamily: "SFProMedium",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextInputFileds(
                                              controlr: dateFrom,
                                              validator: (dateTo) {
                                                if (validDate(dateTo))
                                                  return null;
                                                else
                                                  return "select time";
                                              },
                                              onTapDate: () {
                                                selectTime(context, dateFrom);
                                              },
                                              hintText: Txt.timeFrom,
                                              keyboadType: TextInputType.none,
                                              isPwd: false),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "End Time",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Constants.colors[22],
                                          fontSize: 11.sp,
                                          fontFamily: "SFProMedium",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextInputFileds(
                                          controlr: dateTo,
                                          validator: (dateTo) {
                                            if (validDate(dateTo))
                                              return null;
                                            else
                                              return "select time";
                                          },
                                          onTapDate: () {
                                            FocusScope.of(context).unfocus();
                                            selectTime(context, dateTo);
                                          },
                                          hintText: Txt.timeTo,
                                          keyboadType: TextInputType.none,
                                          isPwd: false),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 15.0),
                            child: Container(
                              width: 20.w,
                              child: SubmitButton(
                                  onPressed: () {
                                    setState(() {
                                      visibility = true;
                                    });

                                    confirmBloc.fetchUserWorkingHours(
                                        token,
                                        item.rowId.toString(),
                                        dateFrom.text,
                                        dateTo.text);
                                  },
                                  label: "Submit",
                                  textColors: Constants.colors[0],
                                  color1: Constants.colors[3],
                                  color2: Constants.colors[4]),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildList(
      AsyncSnapshot<UserViewRequestResponse> snapshot, int position) {
    var allList = getFilterList(snapshot, position);
    var list = [];
    if (position == 0) {
      list = allList.requested;
    }

    if (position == 1) {
      list = allList.confirmed;
    }

    if (position == 2) {
      list = allList.completed;
    }

    if (list.length > 0) {
      return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var items = list[index];
          return Column(
            children: [
              MyBookingListWidget(
                items: items!,
                position: 12,
                onTapView: (item) {
                  showTimeUpdateAlert(context, item);
                },
                onTapCancel: (item) {
                  print("Tapped");

                  canceljob(items);
                },
                onTapCall: () {},
                onTapMap: () {
                  // showFeactureAlert(context, date: "");
                },
                onTapBooking: () {
                  print("Tapped");
                },
                key: null,
              ),
            ],
          );
        },
      );
    } else {
      return Column(
        children: [
          20.height,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Empty Shifts', style: boldTextStyle(size: 20)),
              85.width,
              16.height,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text('There are no shift found.',
                    style: primaryTextStyle(size: 15),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          150.height,
          Image.asset('assets/images/error/empty_task.png', height: 250),
        ],
      );
    }
  }
}

FilterBookingList getFilterList(
    AsyncSnapshot<UserViewRequestResponse> snapshot, int position) {
  FilterBookingList list = FilterBookingList();
  List<Items>? allList = snapshot.data?.response?.data?.items;
  for (var item in allList!) {
    print("item.status");
    print(item.status);
    if (item.status == "Accepted") {
      list.confirmed.add(item);
    }
    if (item.status == "Pending") {
      list.requested.add(item);
    }
    if (item.status == "Rejected") {
      list.reject.add(item);
    }
    if (item.status == "Completed") {
      list.completed.add(item);
    }
  }
  return list;
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,
    );
  }
}
