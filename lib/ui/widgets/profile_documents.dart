import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_doc_row.dart';

import '../../Constants/app_defaults.dart';
import '../../utils/constants.dart';
import 'buttons/drawable_button.dart';

class ProfileDocumentsCard extends StatelessWidget {
  const ProfileDocumentsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Column(
          children: [
            /// TOP PART APPOINTMENT
            Column(
              children: [
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "QQQ1Level 5 Certification",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Infection Prevention ",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Employement Contract Signed",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Passport or ID card",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Any other training or documentation",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label:
                        "Best locations you can work in ? Dubline 15 Finglas",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Do you drive ?. Ye",
                    asset: "assets/images/icon/check.svg"),
                const SizedBox(height: 10),
                ProfileDocRow(
                    label: "Have you got the Covid- 19 vaccination?. Medium",
                    asset: "assets/images/icon/check.svg"),
                SizedBox(height: 10),
                ProfileDocRow(
                    label:
                        "Do youy consent a grada vetting to be Yes ? Completed",
                    asset: "assets/images/icon/check.svg")
              ],
            ),

            /// Bottom Section
          ],
        ),
      ),
    );
  }
}
