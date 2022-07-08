// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../utils/constants.dart';
//
// class HomeCardItem extends StatelessWidget {
//   final String label;
//   final String asset;
//
//   HomeCardItem({
//     Key? key,
//     required this.label,
//     required this.asset,
//   }) : super(key: key);
//
//   bool tapped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       child: Container(
//         alignment: Alignment.center,
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: AutoSizeText(
//                   label,
//                   maxLines: 2,
//                   style: TextStyle(
//                     color: Constants.colors[1],
//                     fontSize: 14.sp,
//                     fontFamily: "SFProMedium",
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.topRight,
//                 child: CircleAvatar(
//                   backgroundColor: Constants.colors[12],
//                   child: SvgPicture.asset(
//                     asset,
//                     height: 5.w,
//                     width: 5.w,
//                     color: Constants.colors[0],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
