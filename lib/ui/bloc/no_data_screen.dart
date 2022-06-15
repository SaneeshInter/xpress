import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class NoDataWidget extends StatelessWidget {
  final String tittle;
  final String description;
  final String asset_image;

  const NoDataWidget({
    Key? key,
    required this.tittle,
    required this.description,
    required this.asset_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          20.height,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(tittle, style: boldTextStyle(size: 20)),
              85.width,
              16.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(description,
                    style: primaryTextStyle(size: 15),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          150.height,
          Image.asset(asset_image, height: 250),
        ],
      ),
    );
  }
}
