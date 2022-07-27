import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/AppColors.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class RemainingTimerWidget extends StatefulWidget {
  final DateTime date;

  const RemainingTimerWidget({Key? key,required this.date}) : super(key: key);

  @override
  State<RemainingTimerWidget> createState() => _RemainingTimerWidgetState();
}

class _RemainingTimerWidgetState extends State<RemainingTimerWidget> {
  String hours = '00:00:00:00';
  int totalSec=0;
  late Timer _timer;
  @override
  void initState() {
    hours = getDiffrenceSecondTwoDates(widget.date, DateTime.now());
    totalSec=getDiffrenceInSecond( DateTime.now(),widget.date);
    _timer= Timer.periodic(const Duration(seconds: 1), (timer){
      hours = getDiffrenceSecondTwoDates(widget.date, DateTime.now());
      totalSec=getDiffrenceInSecond( DateTime.now(),widget.date);
      if(totalSec<=0){
        timer.cancel();
        _timer.cancel();
      }
      if(mounted){
        setState(() {
        });
      }else{
        timer.cancel();
        _timer.cancel();
      }
    });
      setState(() {});
    super.initState();
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return totalSec>0 ?Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Constants
                  .colors[4],Constants
                  .colors[4]]),
          color: Constants.colors[3],
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
          child: Row(
            children: [
              const Icon(Icons.hourglass_bottom,color: white,size: 15,),
              AutoSizeText(
                '${hours.split(":")[0]}:${hours.split(":")[1]}:${hours.split(":")[2]}:${hours.split(":")[3]} ',
                style: TextStyle(
                    fontSize: 8.sp,
                    letterSpacing: 2,
                    color: Constants
                        .colors[0],
                    fontFamily: "SFProMedium",
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    ):const SizedBox();
  }
}
