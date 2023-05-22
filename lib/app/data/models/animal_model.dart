


class AnimalModel{
  int? id;
  int farmId;
  String name;
  String tag;

  AnimalModel({this.id, required this.farmId, required this.name, required this.tag});

  // Método para converter um mapa(Map) em Animal
  factory AnimalModel.fromMap(Map<String, dynamic> json) => AnimalModel(
    id: json["ANM_ID"],
    farmId: json["ANM_FRM_ID"],
    name: json["ANM_NAME"],
    tag: json["ANM_TAG"],
  );

  // Método para converter o Animal em um mapa (Map)
  Map<String, dynamic> toMap() {
    return {
      'ANM_ID': id,
      'ANM_FRM_ID': farmId,
      'ANM_NAME': name,
      'ANM_TAG': tag,
    };
  }
}