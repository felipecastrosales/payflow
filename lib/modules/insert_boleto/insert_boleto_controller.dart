import 'package:flutter/material.dart';

import '../../shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel model = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? 'The name cannot be empty' : null;
  String? validateDueDate(String? value) =>
      value?.isEmpty ?? true ? 'The due date cannot be empty' : null;
  String? validateValue(double value) =>
      value == 0 ? 'Enter an amount greater than \$0.00' : null;
  String? validateCode(String? value) =>
      value?.isEmpty ?? true ? 'Boleto code cannot be empty' : null;

  void onChange({
    String? name, 
    String? dueDate, 
    double? value, 
    String? barcode
  }) => model = model.copyWith(
    name: name, 
    dueDate: dueDate, 
    value: value, 
    barcode: barcode,
  ); 

  Future<void> saveBoleto() async {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList('boletos') ?? <String>[];
    boletos.add(model.toJson());
    await instance.setStringList('boletos', boletos);
    return;
  }

  Future<void> registerBoleto() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveBoleto();
    }
  }
}
