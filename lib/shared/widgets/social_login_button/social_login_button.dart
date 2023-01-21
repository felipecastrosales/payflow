import 'package:flutter/material.dart';

import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: const Border.fromBorderSide(
            BorderSide(color: AppColors.stroke),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.stroke),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: Image.asset(AppImages.google),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter with Google',
                  style: AppTextStyles.buttonGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
