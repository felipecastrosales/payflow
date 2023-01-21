import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';

class PayFlowApp extends StatelessWidget {
  const PayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.primary),
    );

    return MaterialApp(
      title: 'PayFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: AppColors.primary,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/home': (context) => HomePage(
              user: ModalRoute.of(context)?.settings.arguments as UserModel,
            ),
        '/login': (context) => const LoginPage(),
        '/barcode_scanner': (context) => const BarcodeScannerPage(),
        '/insert_boleto': (context) => InsertBoletoPage(
              barcode: ModalRoute.of(context)?.settings.arguments.toString() ??
                  '123456',
            ),
      },
    );
  }
}
