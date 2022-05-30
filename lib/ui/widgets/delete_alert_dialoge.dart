import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Constants/strings.dart';
import '../../utils/utils.dart';

class ActionDeleteAlertBox extends StatelessWidget {
  final String tittle;
  final String message;
  final String positiveText;
  final Function onPositvieClick;
  final Function onNegativeClick;

  const ActionDeleteAlertBox(
      {Key? key,
      required this.tittle,
      required this.message,
      required this.positiveText,
      required this.onPositvieClick,
      required this.onNegativeClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: radius(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: context.cardColor,
          shape: BoxShape.rectangle,
          borderRadius: radius(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image(
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage(
                      'images/widgets/materialWidgets/mwDialogAlertPanelWidgets/widget_delete.jpg'),
                  height: 120,
                  fit: BoxFit.cover),
            ),
            24.height,
            Text(tittle,
                style: boldTextStyle(color: textPrimaryColor, size: 18)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child:
                  Text(message, style: secondaryTextStyle(color: Colors.black)),
            ),
            16.height,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecoration(
                          color: Colors.blueAccent,
                          radius: 8,
                          bgColor: context.scaffoldBackgroundColor),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.close,
                                          color: Colors.blueAccent, size: 18))),
                              TextSpan(
                                  text:Txt.cancel,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blueAccent,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ).onTap(() {
                      finish(context);
                    }),
                  ),
                  16.width,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration:
                          boxDecoration(bgColor: Colors.blueAccent, radius: 8),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white, size: 18))),
                              TextSpan(
                                  text: positiveText,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ).onTap(() {
                      toasty(context,Txt.success_delted);
                      finish(context);
                    }),
                  )
                ],
              ),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
