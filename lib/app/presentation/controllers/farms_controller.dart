

import 'package:flutter/cupertino.dart';

import '../../data/models/farm_model.dart';
import '../../data/services/farms_service.dart';

class FarmsController extends ChangeNotifier {
  FarmsController(){
    getListFarms();
  }

  final FarmsServices _services = FarmsServices();
  List<FarmModel> listFarms = [];


  FarmModel? _farmSelected;
  FarmModel? get farmSelected => _farmSelected;
  set farmSelected(FarmModel? value){
    _farmSelected = value;
    notifyListeners();
  }

  Future<void> getListFarms() async {
    listFarms = await _services.getFarms();
    notifyListeners();
  }

  Future<bool> addFarm(FarmModel farm) async {
    bool result = false;
    await _services.insertFarm(farm).then((value) {
      farm.id = value;
      listFarms.add(farm);
      notifyListeners();
      result = true;
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    return result;
  }

  Future<bool> deleteFarm(int id) async {
    bool result = false;
    await _services.deleteFarm(id).then((value) {
      listFarms.removeWhere((e) => e.id == id);
      notifyListeners();
      result = true;
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    return result;
  }

  Future<void> updateNumAnimals(int num) async {
    listFarms.forEach((element) {
      if(element.id == farmSelected?.id){
        element.numAnimals = num;
      }
    });
  }
}