import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/Constants/AppColors.dart';
import 'package:xpresshealthdev/utils/constants.dart';
import '../../Constants/strings.dart';
import '../../ui/widgets/screen_case.dart';
import '../../services/fcm_service.dart';
import '../../utils/utils.dart';
import '../manager/home/shift_detail_manager.dart';
import '../user/detail/shift_detail.dart';

class NotificationWidget extends StatelessWidget {
  final String name;
  final String startTime;
  final String endTime;
  final String price;
  final String type;
  final String date;

  const NotificationWidget({Key? key, required this.name, required this.price, required this.endTime, required this.type, required this.date, required this.startTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          if (type == 'USER') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (globalContext) => ScreenCase(
                        title: 'Shift Detail',
                        child: ShiftDetailScreen(
                          shift_id: price,
                          isCompleted: true,
                        ),
                      )),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (globalContext) => ScreenCase(
                        title: 'Shift Detail',
                        child: ShiftDetailManagerScreen(
                          shiftId: price,
                        ),
                      )),
            );
          }
        },
        child: Container(
          width: screenWidth(context, dividedBy: 1),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:Constants.colors[0],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                CircleAvatar(
                  child: CachedNetworkImage(
                    imageUrl: startTime,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset("assets/images/icon/loading_bar.gif"),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.w700),
                    maxLines: 2,
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 120)),
                  Text(
                    endTime,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: screenHeight(context, dividedBy: 120)),
                  Row(

                    children: [
                      Text(
                       date.toString()!="null"?getStringFromDate(getDateFromString(date,"yyyy-MM-dd HH:mm:ss"),"hh:mm a dd-MM-yyyy"):"",
                        // date,
                        style: TextStyle(fontSize: 9.sp, color: Colors.grey, fontWeight: FontWeight.w400),textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ]),
                const Spacer(
                  flex: 10,
                ),
                SvgPicture.asset('assets/images/icon/notification.svg'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
