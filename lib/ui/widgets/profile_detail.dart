import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpresshealthdev/ui/user/detail/profile_details_row.dart';
import 'package:xpresshealthdev/model/user_get_response.dart';

import '../../Constants/app_defaults.dart';
import '../../utils/constants.dart';
import '../user/home/profile_edit.dart';
import 'buttons/drawable_button.dart';

class ProfileDetailCard extends StatelessWidget {

  Items items;

ProfileDetailCard({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    String? firstName = items.firstName;
    String? lastName =items.lastName;
    String? employeeNo = items.employeeNo;
    String? gender = items.gender;
    String? dob = items.dob;
    String? homeAddress = items.homeAddress;
    String? email = items.email;
    String? phoneNumber =items.phoneNumber;
    String? ppsNumber = items.ppsNumber;
    String? bankIban =items.bankIban;



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
                          'Personal Details',
                          style: TextStyle(
                              color: Constants.colors[3],
                              fontSize: 18,
                              fontFamily: "SFProMedium",
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        DrawableButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                            );
                          },
                          label: "Edit",
                          asset: "assets/images/icon/swipe-to-right.svg",
                          backgroundColor: Constants.colors[2],
                          textColors: Constants.colors[4],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    if(gender != null)
                    ProfileDetailsRow(
                        label: "Gender : "+gender,
                        asset: "assets/images/icon/sex.svg"),


                    SizedBox(width: 15.0),
                    if(dob != null)
                    ProfileDetailsRow(
                        label: "Date Of Birth :  "+dob,
                        asset: "assets/images/icon/confetti.svg"),


                    SizedBox(width: 15.0),
                    if(homeAddress != null)
                      ProfileDetailsRow(
                          label: "Address :  "+ homeAddress,
                          asset: "assets/images/icon/Pin.svg"),

                    SizedBox(width: 15.0),
                    if(email != null)
                      ProfileDetailsRow(
                        label: "Email :  "+email,
                        asset: "assets/images/icon/email.svg"),


                    SizedBox(width: 15.0),
                    if(phoneNumber != null)
                    ProfileDetailsRow(
                        label: "Phone Number :   "+phoneNumber,
                        asset: "assets/images/icon/phone.svg"),


                    SizedBox(width: 15.0),
                    if(ppsNumber != null)
                    ProfileDetailsRow(
                        label: "PPS Number :  "+ppsNumber,
                        asset: "assets/images/icon/passport.svg"),


                    SizedBox(width: 15.0),
                    if(bankIban != null)
                    ProfileDetailsRow(
                        label: "Bank Details :  "+bankIban,
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
