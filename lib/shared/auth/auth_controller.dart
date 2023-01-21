import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:payflow/shared/models/user_model.dart';

class AuthController {
  UserModel? _user;
  UserModel get user => _user as UserModel;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: user,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> currentUser(
    BuildContext context, [
    bool mounted = true,
  ]) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));

    if (instance.containsKey('user')) {
      final json = instance.get('user') as String;
      if (!mounted) return;
      setUser(context, UserModel.fromJson(json));
      return;
    } else {
      if (!mounted) return;
      setUser(context, null);
    }
  }
}
