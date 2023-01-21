import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  factory LabelButton.primary({
    required String label,
    required VoidCallback onPressed,
  }) =>
      LabelButton(
        label: label,
        onPressed: onPressed,
        style: AppTextStyles.buttonPrimary,
      );

  factory LabelButton.heading({
    required String label,
    required VoidCallback onPressed,
  }) =>
      LabelButton(
        label: label,
        onPressed: onPressed,
        style: AppTextStyles.buttonHeading,
      );

  const LabelButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.style,
  });

  final String label;
  final VoidCallback onPressed;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 56,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: style,
          ),
        ),
      ),
    );
  }
}
