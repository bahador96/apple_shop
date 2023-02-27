class VariantType {
  String? id;
  String? name;
  String? title;

  VariantTypeEnum? type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.color;

    case 'Storage':
      return VariantTypeEnum.storage;

    case 'Voltage':
      return VariantTypeEnum.voltage;

    default:
      return VariantTypeEnum.color;
  }
}

enum VariantTypeEnum { color, storage, voltage }
