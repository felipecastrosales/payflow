import 'package:flutter/material.dart';

import '/../shared/themes/app_colors.dart';
import '/../shared/themes/app_images.dart';
import '/../shared/themes/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: AppColors.stroke)),
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
