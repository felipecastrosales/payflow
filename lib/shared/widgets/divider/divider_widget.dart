import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key, required this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.stroke,
      height: height,
      width: 1,
    );
  }
}
