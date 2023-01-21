import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:payflow/payflow_app.dart';

void main() {
  runApp(const AppFirebase());
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({super.key});

  @override
  State<AppFirebase> createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Material(
            child: Center(
              child: Text(
                'Oops, Unexpected error! :/',
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const PayFlowApp();
        }
        return const Material(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
