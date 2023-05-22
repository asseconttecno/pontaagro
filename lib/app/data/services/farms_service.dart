

import '../database/database.dart';
import '../models/farm_model.dart';

class FarmsServices {
  final DatabaseSqlite database = DatabaseSqlite();

  // Método para listar Animais do banco de dados
  Future<List<FarmModel>> getFarms() async {

    List<FarmModel> list = [];
    final db = await database.db;
    final List<Map<String, dynamic>> listMap = await db.rawQuery('''
      select FRM_ID, FRM_NAME, A.COUNT as COUNT from ${DBTableName.farms.value}
      left join (select ANM_FRM_ID, count(*) as COUNT from ${DBTableName.animals.value} GROUP BY ANM_FRM_ID) A 
      on FRM_ID = ANM_FRM_ID
    ''');
    print(listMap);
    list = listMap.map((e) => FarmModel.fromMap(e)).toList();
    return list;
  }


  // Método para inserir uma Fazenda no banco de dados
  Future<int> insertFarm(FarmModel farm) async {
    final db = await database.db;
    int result = await db.insert(DBTableName.farms.value, farm.toMap());
    return result;
  }


  // Método para deletar uma Fazenda no banco de dados
  Future<int> deleteFarm(int id) async {
    final db = await database.db;
    int result = await db.delete(
        DBTableName.farms.value,
        where: 'FRM_ID = ?',
        whereArgs: [id]
    );
    print(result);
    if(result > 0){
      await db.delete(
          DBTableName.animals.value,
          where: 'ANM_FRM_ID = ?',
          whereArgs: [id]
      );
    }
    return result;
  }
}