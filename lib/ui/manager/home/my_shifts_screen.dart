// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
// import '../../../Constants/strings.dart';
// import '../../../blocs/shift_viewbooking_bloc.dart';
// import '../../../ui/widgets/loading_widget.dart';
//
// import '../../../Constants/sharedPrefKeys.dart';
// import '../../../model/viewbooking_response.dart';
// import '../../../resources/token_provider.dart';
// import '../../../utils/constants.dart';
// import '../../../utils/network_utils.dart';
// import '../../../utils/utils.dart';
// import '../../datepicker/date_picker_widget.dart';
// import '../../error/ConnectionFailedScreen.dart';
// import '../../widgets/manager/my_booking_list_widget.dart';
// import '../create_shift_screen_update.dart';
//
// class ManagerShiftsScreen extends StatefulWidget {
//   const ManagerShiftsScreen({Key? key}) : super(key: key);
//
//   @override
//   _ManagerShiftsState createState() => _ManagerShiftsState();
// }
//
// class _ManagerShiftsState extends State<ManagerShiftsScreen> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   late DateTime _selectedValue;
//   String dateValue = "";
//   String? token;
//   bool visible = false;
//
//   @override
//   void didUpdateWidget(covariant ManagerShiftsScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void initState() {
//     observerResponse();
//     var date = DateTime.now();
//     dateValue = formatDate(date);
//     getDataFromUi();
//     super.initState();
//   }
//
//   Future<void> getDataFromUi() async {
//     token = await TokenProvider().getToken();
//     if (null != token) {
//       if (await isNetworkAvailable()) {
//         viewbookingBloc.fetchViewbooking(token!, dateValue);
//       } else {
//         showInternetNotAvailable();
//       }
//     }
//   }
//
//   Future<void> showInternetNotAvailable() async {
//     int respo = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ConnectionFailedScreen()),
//     );
//     if (respo == 1) {
//       getDataFromUi();
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     viewbookingBloc.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final FixedExtentScrollController itemController =
//         FixedExtentScrollController();
//     double width = MediaQuery.of(context).size.width;
//     return DefaultTabController(
//       length: 2,
//       child:
//           Scaffold(backgroundColor: Constants.colors[9], body: bookingList(0)),
//     );
//   }
//
//   Widget bookingList(int position) {
//     final FixedExtentScrollController itemController =
//         FixedExtentScrollController();
//     return SingleChildScrollView(
//       child: Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: screenWidth(context, dividedBy: 35)),
//           child: Column(children: [
//             SizedBox(height: screenHeight(context, dividedBy: 60)),
//             DatePicker(
//               DateTime.now(),
//               initialSelectedDate: DateTime.now(),
//               selectionColor: Constants.colors[20],
//               selectedTextColor: Constants.colors[0],
//               width: 18.w,
//               height: 22.w,
//               deactivatedColor: Colors.blue,
//               monthTextStyle: TextStyle(color: Colors.transparent),
//               dateTextStyle: TextStyle(
//                   color: Constants.colors[21],
//                   fontWeight: FontWeight.w800,
//                   fontSize: 16.sp),
//               dayTextStyle: TextStyle(
//                   color: Constants.colors[21],
//                   fontWeight: FontWeight.w500,
//                   fontSize: 4.sp),
//               selectedDateStyle: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16.sp),
//               selectedDayStyle: TextStyle(
//                   color: Constants.colors[0],
//                   fontWeight: FontWeight.w500,
//                   fontSize: 4.sp),
//               itemController: itemController,
//               onDateChange: (date, x) {
//                 // New date selected
//                 setState(() {
//                   _selectedValue = date;
//                   dateValue = formatDate(date);
//                   viewbookingBloc.allShifts.drain();
//                   getDataFromUi();
//                 });
//               },
//             ),
//             SizedBox(height: 2.h),
//             Stack(
//               children: [
//                 Column(
//                   children: [
//                     StreamBuilder(
//                         stream: viewbookingBloc.allShifts,
//                         builder: (BuildContext context,
//                             AsyncSnapshot<ManagerScheduleListResponse>
//                                 snapshot) {
//                           if(!snapshot.hasData || null==snapshot.data  || null == snapshot.data?.response?.data?.items)
//                             {
//                               return const SizedBox();
//                             }
//                           return buildList(snapshot);
//
//                         }),
//                   ],
//                 ),
//                 Container(
//                   width: 100.w,
//                   height: 50.h,
//                   child: StreamBuilder(
//                     stream: viewbookingBloc.visible,
//                     builder: (context, AsyncSnapshot<bool> snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.data!) {
//                           return const Center(child: LoadingWidget());
//                         } else {
//                           return const SizedBox();
//                         }
//                       } else {
//                         return const SizedBox();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ])),
//     );
//   }
//
//   String formatDate(DateTime date) {
//     DateFormat formatter = DateFormat('dd-MM-yyyy');
//     final String formatted = formatter.format(date);
//     return formatted;
//   }
//
//   void observerResponse() {
//     viewbookingBloc.removeshift.listen((event) {
//       debugPrint(event.response?.status?.statusCode.toString());
//
//       var message = event.response?.status?.statusMessage;
//
//       if (event.response?.status?.statusCode == 200) {
//         getDataFromUi();
//       } else {
//         showAlertDialoge(context, title: Txt.failed, message: message!);
//       }
//     });
//   }
//
//   // Future deleteShift(rowId) async {
//   //   String? token = await TokenProvider().getToken();
//   //   viewbookingBloc.fetchRemoveManager(token!, rowId.toString());
//   // }
//
//   Widget buildList(AsyncSnapshot<ManagerScheduleListResponse> snapshot) {
//     return ListView.builder(
//       itemCount: snapshot.data?.response?.data?.items?.length,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (BuildContext context, int index) {
//         var items = snapshot.data?.response?.data?.items![index];
//
//         return Column(
//           children: [
//             if(null!=items)
//             ManagerBookingListWidget(
//               items: items,
//               onTapView: () {},
//               key: null,
//               onTapItem: () {},
//               onTapEdit: (item) {
//                 debugPrint(item.toString());
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CreateShiftScreenUpdate(
//                               shiftItem: items,
//                             )));
//               },
//               onTapDelete: (row_id) {
//                 debugPrint(row_id.toString());
//                 setState(() {
//                   visible = true;
//                 });
//               //  deleteShift(row_id);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
