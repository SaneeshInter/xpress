import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: SizedBox(
        width: 16.w,
        child: Padding(
          padding: padding,
          child: Column(
            children: <Widget>[
              Checkbox(
                fillColor: MaterialStateColor
                      .resolveWith(
                          (states) =>
                              Colors
                                  .green),
                activeColor: Colors.green,
                checkColor: Colors.white,
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue!);
                },
              ),

              AutoSizeText(label,style: const TextStyle(fontSize: 7)),

            ],
          ),
        ),
      ),
    );
  }
}