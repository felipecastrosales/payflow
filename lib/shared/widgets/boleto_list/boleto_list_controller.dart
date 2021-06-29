import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/models/boleto_model.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  void getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos');
      boletos = response!.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}
