import 'package:flutter/material.dart';

import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/my_boletos/my_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'Hello, ',
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: 'Felipe',
                      style: AppTextStyles.titleBoldBackground,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Keep your accounts up to date',
                style: AppTextStyles.captionShape,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.user.photoURL ?? AppImages.logomini,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MyBoletosPage(key: UniqueKey()),
        ExtractPage(key: UniqueKey()),
      ][controller.currentPage],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() => controller.setPage(0));
              },
              icon: Icon(
                Icons.home,
                color: controller.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  '/barcode_scanner',
                );
                setState(() {});
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => controller.setPage(1));
              },
              icon: Icon(
                Icons.description_outlined,
                color: controller.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
