import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/strings.dart';

class ConnectionFailedScreen extends StatefulWidget {
  const ConnectionFailedScreen({Key? key}) : super(key: key);

  @override
  _ConnectionFailedScreenState createState() => _ConnectionFailedScreenState();
}

class _ConnectionFailedScreenState extends State<ConnectionFailedScreen> {
  @override
  void initState() {
    // setStatusBarColor(Color(0xFFDEE0E8));
    super.initState();
  }

  @override
  void dispose() {
    // setStatusBarColor(Color(0xFFDEE0E8));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/error/nw_error.png',
            fit: BoxFit.cover,
            width: 100.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(Txt.connection_failed,
                  style: boldTextStyle(size: 30, color: Colors.black54)),
              16.height,
              Text(
                Txt.retry_again,
                style: primaryTextStyle(size: 18, color: Colors.black45),
                textAlign: TextAlign.center,
              ).paddingSymmetric(vertical: 8, horizontal: 40),
              32.height,
              AppButton(
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(30)),
                color: const Color(0xFF5ECB42),
                padding: const EdgeInsets.all(16),
                onTap: () {
                  // toast('RETRY');
                  Navigator.pop(context, 1);
                },
                child: Text(Txt.retry, style: boldTextStyle(color: white))
                    .paddingSymmetric(horizontal: 32),
              ),
              100.height,
            ],
          ),
        ],
      ),
    );
  }
}
