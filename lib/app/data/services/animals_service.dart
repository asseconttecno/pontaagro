

import '../database/database.dart';
import '../models/animal_model.dart';


class AnimalsServices{
  final DatabaseSqlite database = DatabaseSqlite();

  // Método para listar Animais do banco de dados
  Future<List<AnimalModel>> getAnimals(int idFarm) async {
    List<AnimalModel> list = [];
    final db = await database.db;
    final List<Map<String, dynamic>> listMap = await db.query(
        DBTableName.animals.value,
        where: 'ANM_FRM_ID = ?',
        whereArgs: [idFarm]
    );
    list = listMap.map((e) => AnimalModel.fromMap(e)).toList();
    return list;
  }

  // Método para inserir Animais no banco de dados
  Future<bool> insertAnimal(List<AnimalModel> animals) async {
    if(animals.isNotEmpty){
      final db = await database.db;
      final batch = db.batch();
      animals.forEach((animal) {
        batch.insert(DBTableName.animals.value, animal.toMap());
      });
      await batch.commit();
      return true;
    }
    return false;
  }

  // Método para deletar Animais no banco de dados
  Future<int> deleteAnimals(int id) async {
    final db = await database.db;
    final int _idresult = await db.delete(
        DBTableName.animals.value,
        where: 'ANM_ID = ?',
        whereArgs: [id]
    );
    return _idresult;
  }
}