
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../config/theme_colors.dart';
import '../controllers/home_controller.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (_, home,__) {
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      ThemeColors.priColor,
                      ThemeColors.mainColor
                    ]),
              ),
              child: Image.asset('assets/capa.jpg', fit: BoxFit.fitWidth,),
            )
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: home.pageController,
            children:  Routes.pages(),
          ),
        );
      }
    );
  }
}
