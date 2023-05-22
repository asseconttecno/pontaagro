import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  int page = 0;

  void setPage(int value){
    if(value == page){
      return;
    }
    page = value;
    pageController.jumpToPage(value);
    notifyListeners();
  }
}