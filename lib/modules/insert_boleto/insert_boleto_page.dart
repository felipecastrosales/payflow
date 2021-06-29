import 'package:flutter/material.dart';

import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'insert_boleto_controller.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/input_text/input_text_widget.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {

  final controller = InsertBoletoController();
  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: '\$', 
    initialValue: 0, 
    decimalSeparator: ',',
  );
  final dueDateInputTextController = MaskedTextController(mask: '00/00/0000');
  final barcodeInputTextController = TextEditingController();
  
  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(93, 24, 93, 24),
                child: Text(
                  'Fill in the payment slip data',
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: 'Boleto name',
                      icon: Icons.description_outlined,
                      onChanged: (value) => controller.onChange(name: value),
                      validator: controller.validateName,
                    ),
                    InputTextWidget(
                      controller: dueDateInputTextController,
                      label: 'Due date',
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) => controller.onChange(dueDate: value),
                      validator: controller.validateDueDate,
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: 'Price',
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller.validateValue(
                        moneyInputTextController.numberValue,
                      ),
                      onChanged: (value) => controller.onChange(
                        value: moneyInputTextController.numberValue,
                      ),
                    ),
                    InputTextWidget(
                      controller: barcodeInputTextController,
                      label: 'Code',
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCode,
                      onChanged: (value) => controller.onChange(barcode: value),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, thickness: 1, color: AppColors.stroke),
          SetLabelButtons(
            enableSecondaryColor: true,
            labelPrimary: 'Cancel',
            onTapPrimary: () {
              Navigator.pop(context);
            },
            labelSecondary: 'Register',
            onTapSecondary: () async {
              await controller.registerBoleto();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
