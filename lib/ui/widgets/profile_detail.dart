import 'package:flutter/material.dart';
import '../../model/user_get_response.dart';
import '../../ui/user/detail/profile_details_row.dart';

import '../../Constants/app_defaults.dart';
import '../../Constants/strings.dart';
import '../../utils/constants.dart';
import '../../utils/network_utils.dart';
import 'buttons/drawable_button.dart';

class ProfileDetailCard extends StatelessWidget {
  Items items;
  final Function onPressed;

  ProfileDetailCard({Key? key, required this.items, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? gender = items.gender;
    String? dob = items.dob;
    String? homeAddress = items.homeAddress;
    String? email = items.email;
    String? phoneNumber = items.phoneNumber;
    String? ppsNumber = items.ppsNumber;
    String? bankIban = items.bankIban;

    return Material(
      color: Colors.white,
      borderRadius: AppDefaults.borderRadius,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppDefaults.borderRadius,
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
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
                        Text(
                          Txt.prsnl_details,
                          style: TextStyle(
                              color: Constants.colors[3],
                              fontSize: 18,
                              fontFamily: "SFProMedium",
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        DrawableButton(
                          onPressed: () {
                            onPressed();
                          },
                          label: Txt.edit,
                          asset: "assets/images/icon/edit.svg",
                          backgroundColor: Constants.colors[2],
                          textColors: Constants.colors[4],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(
                      thickness: 0.5,
                      endIndent: 7,
                      indent: 2,
                      color: Constants.colors[25],
                    ),
                    const SizedBox(height: 8.0),
                    if (gender != null)
                      ProfileDetailsRow(
                          label: Txt.gender_dot + gender,
                          asset: "assets/images/icon/sex.svg"),
                    SizedBox(width: 15.0),
                    if (dob != null)
                      ProfileDetailsRow(
                          label: Txt.d_o_b + dob,
                          asset: "assets/images/icon/confetti.svg"),
                    SizedBox(width: 15.0),
                    if (homeAddress != null)
                      ProfileDetailsRow(
                          label: Txt.address_dot + homeAddress,
                          asset: "assets/images/icon/Pin.svg"),
                    SizedBox(width: 15.0),
                    if (email != null)
                      GestureDetector(
                        onTap: () {
                          sendingMails(email);
                        },
                        child: ProfileDetailsRow(
                            label: Txt.email_dot + email,
                            asset: "assets/images/icon/email.svg"),
                      ),
                    SizedBox(width: 15.0),
                    if (phoneNumber != null)
                      GestureDetector(
                        onTap: () {
                          dialCall(phoneNumber);
                        },
                        child: ProfileDetailsRow(
                            label: Txt.phone_number_dot + phoneNumber,
                            asset: "assets/images/icon/phone.svg"),
                      ),
                    SizedBox(width: 15.0),
                    if (ppsNumber != null)
                      ProfileDetailsRow(
                          label: Txt.pps_number_dot + ppsNumber,
                          asset: "assets/images/icon/passport.svg"),
                    SizedBox(width: 15.0),
                    if (bankIban != null)
                      ProfileDetailsRow(
                          label: Txt.bank_detail + bankIban,
                          asset: "assets/images/icon/bank.svg"),
                    SizedBox(width: 15.0),
                  ],
                ),
              ),

              /// Bottom Section
            ],
          ),
        ),
      ),
    );
  }
}
