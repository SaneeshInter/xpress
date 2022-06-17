import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import '../../Constants/strings.dart';
import '../../blocs/createshift_manager_bloc.dart';
import '../../dbmodel/allowance_category_model.dart';
import '../../dbmodel/allowance_mode.dart';
import '../../utils/utils.dart';
import '../../utils/validator.dart';
import 'input_text.dart';

class AllowanceBottomSheet extends StatefulWidget {
  final int value;
  final Function onTapView;
  final Function onSumbmit;

  const AllowanceBottomSheet(
      //list
      {Key? key,
      required this.onTapView,
      required this.onSumbmit,
      required this.value})
      : super(key: key);

  @override
  _AllowanceState createState() => _AllowanceState();
}

class _AllowanceState extends State<AllowanceBottomSheet> {
  var allowanceCategroyId = 1;
  var allowanceId = 1;
  var allowanceCategroy = "Food Item";
  var allowance = "Break Fast";
  TextEditingController allowanceprice =  TextEditingController();


  @override
  void initState() {

    super.initState();
    managerBloc.getModelDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            Txt.allowances,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "SFProMedium",
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 50.w,
                  child: StreamBuilder(
                    stream: managerBloc.typeAllowancesCategroys,
                    builder: (context,
                        AsyncSnapshot<List<AllowanceCategoryList>> snapshot) {
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                            contentPadding: const EdgeInsets.all(3.0),
                            labelText:Txt.category,
                            labelStyle: TextStyle(fontSize: 10.sp)),
                        items: snapshot.data?.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.category!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  decoration: TextDecoration.none,
                                  color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (Object? value) {
                          print("value");
                          if (value is AllowanceCategoryList) {
                             allowanceId = 1;
                             allowanceCategroy = "Food Item";
                            print("value ");
                            print(value.category);
                            managerBloc.typeAllowancesList.drain();
                            managerBloc.getAllowanceList(value.rowId!);
                            allowanceCategroyId = value.rowId!;
                            allowanceCategroy = value.category!;
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: 50.w,
                  child: StreamBuilder(
                    stream: managerBloc.typeAllowancesList,
                    builder:
                        (context, AsyncSnapshot<List<AllowanceList>> snapshot) {
                      if (snapshot.hasData&&snapshot.data?.length != 0&&snapshot.data?.length != 0) {

                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                contentPadding: const EdgeInsets.all(3.0),
                                labelText:Txt.allowances,

                                labelStyle: TextStyle(fontSize: 10.sp)),
                            items: snapshot.data?.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.allowance!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                      decoration: TextDecoration.none,
                                      color: Colors.grey),
                                ),
                              );
                            }).toSet().toList(),
                            onChanged: (Object? value) {
                              if (value is AllowanceList) {
                                allowanceId = value.rowId!;
                                allowance = value.allowance!;
                              }
                            },
                          );
                        } else {
                          return const SizedBox();
                        }

                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            children: [
              TextInputFileds(
                  controlr: allowanceprice,
                  onChange: (){},   validator: (date) {
                    if (validDate(date))
                      return null;
                    else
                      return Txt.enter_price;
                  },
                  onTapDate: () {},
                  hintText: Txt.price,
                  keyboadType: TextInputType.number,
                  isPwd: false),
            ],
          ),
          ElevatedButton(
            onPressed: () {
                managerBloc.addAllowances(allowanceId, allowanceCategroyId,
                    allowance, allowanceCategroy, allowanceprice.text);
                pop(context);

            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
              Txt.add_allowances  ,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}
