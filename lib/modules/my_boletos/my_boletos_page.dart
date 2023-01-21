import 'package:flutter/material.dart';

import 'package:animated_card/animated_card.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';

class MyBoletosPage extends StatefulWidget {
  const MyBoletosPage({super.key});

  @override
  State<MyBoletosPage> createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  color: AppColors.primary,
                ),
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
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              'My tickets',
              style: AppTextStyles.titleBoldHeading,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: AppColors.stroke,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
            ),
          )
        ],
      ),
    );
  }
}
