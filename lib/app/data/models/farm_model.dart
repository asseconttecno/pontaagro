

class FarmModel{
  int? id;
  String name;
  int numAnimals;

  FarmModel({this.id, required this.name, this.numAnimals = 0});

  // Método para converter um mapa(Map) em Fazenda
  factory FarmModel.fromMap(Map<String, dynamic> json) => FarmModel(
    id: json["FRM_ID"],
    name: json["FRM_NAME"],
    numAnimals: json["COUNT"] ?? 0,
  );

  // Método para converter o Fazenda em um mapa (Map)
  Map<String, dynamic> toMap() {
    return {
      'FRM_ID': id,
      'FRM_NAME': name,
    };
  }
}