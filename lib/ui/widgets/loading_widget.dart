import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Constants/strings.dart';

import '../../Constants/AppColors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingWidget> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: .1,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: const EdgeInsets.all(0.0),
      content: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: appColorPrimary),
            const SizedBox(height: 16),
            Text(Txt.plz_wait,
                style: primaryTextStyle(color: cardBackgroundBlackDark)),
          ],
        ),
      ),
    );
  }
}
