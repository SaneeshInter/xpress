import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Constants/app_defaults.dart';
import '../../../utils/constants.dart';
import '../../widgets/buttons/drawable_button.dart';


class DrawbleRow extends StatelessWidget {
  const DrawbleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(


      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppDefaults.borderRadius,
          boxShadow: const [
            BoxShadow(
              color: Colors.red,
              offset: Offset(2, 0),
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          children: [
            /// TOP PART APPOINTMENT
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                vertical: AppDefaults.padding,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          'At : St george Hospital',
                          style: TextStyle(
                              color: Constants.colors[3],
                              fontSize: 18,
                              fontFamily: "SFProMedium",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        child: Text(
                          'At : St george Hospital',
                          style: TextStyle(
                              color: Constants.colors[3],
                              fontSize: 18,
                              fontFamily: "SFProMedium",
                              fontWeight: FontWeight.w700),
                        ),

                      ),
                    ],

                  ),],
              ),
            ),

            /// Bottom Section
          ],
        ),
      ),
    );
  }
}
