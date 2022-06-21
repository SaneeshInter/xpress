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
  final _formKey = GlobalKey<FormState>();

  TextEditingController allowanceprice = TextEditingController();

  @override
  void initState() {
    super.initState();
    managerBloc.getModelDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
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
                        return
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.black12, width: 1, style: BorderStyle.solid),),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: DropdownButton<AllowanceCategoryList>(
                                value: managerBloc.selectedAllowanceCategory,
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),

                                underline: const SizedBox(),
                                onChanged: (Object? newValue) {
                                  print("value");
                                  if (newValue is AllowanceCategoryList) {
                                    allowanceId = 1;
                                    allowanceCategroy = "Food Item";
                                    print("value ");
                                    print(newValue.category);
                                    managerBloc.typeAllowancesList.drain();
                                    managerBloc.getAllowanceList(newValue.rowId!);
                                    allowanceCategroyId = newValue.rowId!;
                                    allowanceCategroy = newValue.category!;
                                  }
                                },
                                items: snapshot.data
                                    ?.map<DropdownMenuItem<AllowanceCategoryList>>(
                                        (AllowanceCategoryList value) {
                                      return DropdownMenuItem<AllowanceCategoryList>(
                                        value: value,
                                        child: Text(value.category!),
                                      );
                                    }).toList(),
                              ),
                            ),
                          );
                        //   DropdownButtonFormField(
                        //   decoration: InputDecoration(
                        //       enabledBorder: const OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(5)),
                        //         borderSide: BorderSide(color: Colors.grey),
                        //       ),
                        //       focusedBorder: const OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(8.0)),
                        //           borderSide:
                        //               BorderSide(color: Colors.grey, width: 1)),
                        //       contentPadding: const EdgeInsets.all(3.0),
                        //       labelText: Txt.category,
                        //       labelStyle: TextStyle(fontSize: 10.sp)),
                        //   items: snapshot.data?.map((item) {
                        //     return DropdownMenuItem(
                        //       value: item,
                        //       child: Text(
                        //         item.category!,
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 10.sp,
                        //             decoration: TextDecoration.none,
                        //             color: Colors.grey),
                        //       ),
                        //     );
                        //   }).toList(),
                        //   onChanged: (Object? value) {
                        //     print("value");
                        //     if (value is AllowanceCategoryList) {
                        //       allowanceId = 1;
                        //       allowanceCategroy = "Food Item";
                        //       print("value ");
                        //       print(value.category);
                        //       managerBloc.typeAllowancesList.drain();
                        //       managerBloc.getAllowanceList(value.rowId!);
                        //       allowanceCategroyId = value.rowId!;
                        //       allowanceCategroy = value.category!;
                        //     }
                        //   },
                        // );
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
                        if (snapshot.hasData &&
                            snapshot.data?.length != 0 &&
                            snapshot.data?.length != 0) {
                          debugPrint(
                              "snapshot.data.length ${snapshot.data!.length} ${snapshot.data![0].allowance}");
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.black12, width: 1, style: BorderStyle.solid),),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: DropdownButton<AllowanceList>(
                                value: managerBloc.selectedAllowance,
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),

                                underline: const SizedBox(),
                                onChanged: (Object? newValue) {
                                  if (newValue is AllowanceList) {
                                    allowanceId = newValue.rowId!;
                                    allowance = newValue.allowance!;
                                    managerBloc.selectedAllowance= newValue;
                                    setState(() {});
                                  }
                                },
                                items: snapshot.data
                                    ?.map<DropdownMenuItem<AllowanceList>>(
                                        (AllowanceList value) {
                                  return DropdownMenuItem<AllowanceList>(
                                    value: value,
                                    child: Text(value.allowance!),
                                  );
                                }).toList(),
                              ),
                            ),
                          );

                          //   DropdownButtonFormField(
                          //   decoration: InputDecoration(
                          //       enabledBorder: const OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5.0)),
                          //         borderSide: BorderSide(color: Colors.grey),
                          //       ),
                          //       focusedBorder: const OutlineInputBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(8.0)),
                          //           borderSide: BorderSide(
                          //               color: Colors.grey, width: 1)),
                          //       contentPadding: const EdgeInsets.all(3.0),
                          //       labelText:Txt.allowances,
                          //
                          //       labelStyle: TextStyle(fontSize: 10.sp)),
                          //   items: snapshot.data?.map((item) {
                          //     return DropdownMenuItem(
                          //       value: item,
                          //       child: Text(
                          //         item.allowance!,
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 10.sp,
                          //             decoration: TextDecoration.none,
                          //             color: Colors.grey),
                          //       ),
                          //     );
                          //   }).toSet().toList(),
                          //   onChanged: (Object? value) {
                          //     if (value is AllowanceList) {
                          //       allowanceId = value.rowId!;
                          //       allowance = value.allowance!;
                          //     }
                          //   },
                          // );
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
                    onChange: () {},
                    validator: (val) {
                      if (val.toString()!="" && (double.parse(val??"0")>0))
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
                if (_formKey.currentState!.validate()) {
                  managerBloc.addAllowances(allowanceId, allowanceCategroyId,
                      allowance, allowanceCategroy, allowanceprice.text);
                  pop(context);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  Txt.add_allowances,
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
      ),
    );
  }
}
