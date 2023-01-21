import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  final pageController = PageController();

  void setPage(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
