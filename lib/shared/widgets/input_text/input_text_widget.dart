import 'package:flutter/material.dart';

import 'package:animated_card/animated_card.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.initalValue,
    this.validator,
    this.controller,
  });

  final String label;
  final IconData icon;
  final String? initalValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.top,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              initialValue: initalValue,
              validator: validator,
              onChanged: onChanged,
              style: AppTextStyles.input,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: label,
                labelStyle: AppTextStyles.input,
                border: InputBorder.none,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.stroke,
            ),
          ],
        ),
      ),
    );
  }
}
