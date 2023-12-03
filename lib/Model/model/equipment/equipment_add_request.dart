class EquipmentAddRequest {
  String category;
  String? description;
  String? imgKey;
  String? location;
  String name;
  String quantity;

  EquipmentAddRequest({
    required this.category,
    required this.description,
    required this.imgKey,
    required this.location,
    required this.name,
    required this.quantity,
  });

  factory EquipmentAddRequest.fromJson(Map<String, dynamic> json) =>
      EquipmentAddRequest(
        category: json["category"],
        description: json["description"],
        imgKey: json["imgKey"],
        location: json["location"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "imgKey": imgKey,
        "location": location,
        "name": name,
        "quantity": quantity,
      };
}
