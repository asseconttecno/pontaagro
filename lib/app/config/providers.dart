

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/database/database.dart';
import '../presentation/controllers/animals_controller.dart';
import '../presentation/controllers/farms_controller.dart';
import '../presentation/controllers/home_controller.dart';


class Providers {

  static List<SingleChildWidget> listDefault(){
    return [
      Provider(
        create: (_)=>  DatabaseSqlite(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_)=>  FarmsController(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_)=>  AnimalsController(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_)=>  HomeController()
      ),
    ];
  }

}