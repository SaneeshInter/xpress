import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';


class ShiftStatusChip extends StatelessWidget {
  ShiftStatusChip(
      { Key? key,
      required this.label,
      required this.selectedColor,
       this.unselectedColor=Colors.white,
       this.textColor=Colors.black,
      required this.selected,
      required this.onPressed}) : super(key: key);
String label;
  Color selectedColor;
  Color unselectedColor;
  Color textColor;
  bool selected;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: ColoredBox(
            color:selected ? selectedColor : unselectedColor,
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(label, style: TextStyle(color:selected ?textColor:black),),
            ),
          ),
        ),
      ),
    );
  }


}
