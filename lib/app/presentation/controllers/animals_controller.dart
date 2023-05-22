

import 'package:flutter/cupertino.dart';

import '../../data/models/animal_model.dart';
import '../../data/services/animals_service.dart';

class AnimalsController extends ChangeNotifier {
  final AnimalsServices _services = AnimalsServices();

  List<AnimalModel> _listAnimals = [];
  List<AnimalModel> get listAnimals => _listAnimals;
  set listAnimals(List<AnimalModel> value){
    _listAnimals = value;
    notifyListeners();
  }

  void removeListAnimals(AnimalModel animal){
    listAnimals.remove(animal);
    notifyListeners();
  }

  void addListAnimals(AnimalModel animal){
    listAnimals.add(animal);
    notifyListeners();
  }

  Future<List<AnimalModel>> getListAnimals(int idFarm) async {
    List<AnimalModel> listAnimals = [];
    listAnimals = await _services.getAnimals(idFarm);
    return listAnimals;
  }

  Future<bool> addAnimals() async {
    bool result = false;
    if(listAnimals.isNotEmpty && listAnimals.first.name != '' && listAnimals.first.tag != '') {
      await _services.insertAnimal(listAnimals).then((value) {
        _listAnimals.clear();
        result = true;
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
    return result;
  }

  Future<bool> deleteAnimal(int id) async {
    bool result = false;
    await _services.deleteAnimals(id).then((value) {
      result = true;
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    return result;
  }
}