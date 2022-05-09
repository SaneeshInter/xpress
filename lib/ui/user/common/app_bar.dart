import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/user/sidenav/notification_screen.dart';

import '../../../utils/colors_util.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> scaffoldKey;

  AppBarCommon(GlobalKey<ScaffoldState> key, {required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/images/icon/menu.svg',
          width: 5.w,
          height: 4.2.w,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      bottomOpacity: 0.0,
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
                height: 8.w,
              )),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
          icon: SvgPicture.asset(
            'assets/images/icon/notification.svg',

            width: 5.w,
            color: Colors.black,
            height: 5.w,
          ), //Image.asset('assets/images/icon/searchicon.svg',width: 20,height: 20,fit: BoxFit.contain,),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
