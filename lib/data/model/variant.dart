class Variant {
  String? id;
  String? name;
  String? typeID;
  String? value;
  int? priceChannge;

  Variant(
    this.id,
    this.name,
    this.typeID,
    this.value,
    this.priceChannge,
  );

  factory Variant.fromJson(Map<String, dynamic> jsonObject) {
    return Variant(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['type_id'],
      jsonObject['value'],
      jsonObject['price_change'],
    );
  }
}
