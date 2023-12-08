import 'package:flutter/material.dart';
import 'package:openvpn_test_app/main.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget(
      {super.key,
      required this.titleText,
      required this.subTitleText,
      required this.roundWidgetWithIcon});

  final String titleText;
  final String subTitleText;
  final Widget roundWidgetWithIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeScreen.width * 0.46,
      child: Column(
        children: [
          roundWidgetWithIcon,
          const SizedBox(
            height: 7,
          ),
          Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            subTitleText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
