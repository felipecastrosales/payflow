import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/boleto_model.dart';

class BoletoListController {
  BoletoListController() {
    getBoletos();
  }
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  void getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos');
      boletos =
          response?.map((boleto) => BoletoModel.fromJson(boleto)).toList() ??
              <BoletoModel>[];
    } catch (e, s) {
      debugPrint('Error when getting boletos ${e.toString()}');
      debugPrint('Stack when getting boletos ${s.toString()}');
    }
  }

  void dispose() {
    boletosNotifier.dispose();
  }
}
