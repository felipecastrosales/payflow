import 'package:flutter/material.dart';

import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    super.initState();
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/insert_boleto',
            arguments: controller.status.barcode,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  color: Colors.red,
                  height: MediaQuery.of(context).size.height,
                  width: 800,
                  child: controller.cameraController?.buildPreview(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text(
                  'Scan the boleto\'s barcode',
                  style: AppTextStyles.buttonBackground,
                ),
                leading: const BackButton(
                  color: AppColors.background,
                ),
              ),
              bottomNavigationBar: SetLabelButtons(
                labelPrimary: 'Insert boleto code',
                onTapPrimary: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/insert_boleto',
                  );
                },
                labelSecondary: 'Add from gallery',
                onTapSecondary: controller.scanWithImagePicker,
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: BottomSheetWidget(
                    title: 'Unable to identify a barcode.',
                    subtitle:
                        'Try scanning again or enter your bill of exchange code.',
                    labelPrimary: 'Rescan',
                    onTapPrimary: () {
                      controller.scanWithCamera();
                    },
                    labelSecondary: 'Enter code',
                    onTapSecondary: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/insert_boleto',
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
