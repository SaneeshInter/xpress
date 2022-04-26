import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingWidget> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tapped = true;
        });
      },
      child: Center(
        child: Container(
          color: Colors.white,
          width: 30.w,
          height: 30.w,
          child: Lottie.asset('assets/images/icon/loading.json',
              width: 30.h, height: 30.w),
        ),
      ),
    );
  }
}
