import 'package:flutter/material.dart';

import 'package:animated_card/animated_card.dart';

import '../../shared/models/boleto_model.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/boleto_list/boleto_list_controller.dart';
import '../../shared/widgets/boleto_list/boleto_list_widget.dart';
import '../../shared/widgets/boleto_info/boleto_info_widget.dart';

class MyBoletosPage extends StatefulWidget {
  MyBoletosPage({Key? key}) : super(key: key);

  @override
  _MyBoletosPageState createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 80,
            child: Stack(
              children: [
                Container(height: 40, color: AppColors.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (_, boletos, __) => AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfoWidget(
                        size: boletos.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,),
            child: Row(
              children: [
                Text('My tickets', style: AppTextStyles.titleBoldHeading),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(color: AppColors.stroke),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(controller: controller),
          )
        ],
      ),
    );
  }
}
