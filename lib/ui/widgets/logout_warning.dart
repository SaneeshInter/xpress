import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/utils.dart';


class LogoutWarning extends StatelessWidget {
  const LogoutWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        "Logout",
        style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700),
      ),
      content: Text(
        "Are you sure, Do you want to logout !",
        style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,),
      ),
      actions: [
        TextButton(
          child: Text(
            'No',
            style: TextStyle(
                fontSize: 10.sp,
                color: Colors.green,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Yes',
            style: TextStyle(
                fontSize: 10.sp,
                color: Colors.green,
                fontWeight: FontWeight.w400),
          ),
          onPressed: () async{
           await logOut(context);
          },
        ),
      ],
    );
  }
}