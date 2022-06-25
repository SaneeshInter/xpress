import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/strings.dart';
import '../../../utils/colors_util.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  String notificationCount;

  AppBarCommon(GlobalKey<ScaffoldState> key, {required this.scaffoldKey,required this.notificationCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const newRouteName = "/NotificationScreen";
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/icon/menu.svg',
          width: 5.w,
          height: 4.2.w,
        ),
        onPressed: () {

          bool isNewRouteSameAsCurrent = false;
          Navigator.popUntil(context, (route) {
            if (route.settings.name == newRouteName) {
              isNewRouteSameAsCurrent = true;
            }
            return true;
          });

          if (!isNewRouteSameAsCurrent) {
            scaffoldKey.currentState?.openDrawer();

          }
        },
      ),
      bottomOpacity: 0.0,
      elevation: 0.0,
      iconTheme: const IconThemeData(
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
                height: 8.w,
              )),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            const newRouteName = "/NotificationScreen";
            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });

            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }

          },
          icon: Badge(
            badgeContent:  Text(notificationCount,style: const TextStyle(color: white,fontSize: 10),),
            child: SvgPicture.asset(
              'assets/images/icon/notification.svg',

              width: 5.w,
              color: Colors.black,
              height: 5.w,
            ),
          ), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}
//logout warning
