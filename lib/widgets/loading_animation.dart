import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,

          /// Required, The loading type of the widget
          colors: [CustomColors.blue],

          /// Optional, The color collections
          strokeWidth: 0.1,
        ),
      ),
    );
  }
}
