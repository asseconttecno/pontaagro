
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../presentation/controllers/home_controller.dart';
import '../presentation/views/animals/add_animal.dart';
import '../presentation/views/animals/animals.dart';
import '../presentation/views/farms/farms.dart';


enum Routes {
  farms(0),
  animals(1),
  addAnimals(2);

  final int value;
  const Routes(this.value);

  /// Metodo para trocar de view no PageView da Home.dart
  void navigator(BuildContext context){
    context.read<HomeController>().setPage(value);
  }

  /// Lista de view utilizado no PageView da Home.dart
  static List<Widget> pages(){
    return const <Widget>[
      FarmsView(),
      AnimalsView(),
      AddAnimalsView(),
    ];
  }
}