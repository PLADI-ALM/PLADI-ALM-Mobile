class MyInfoRequest {
  String assets;
  String name;
  String phone;

  MyInfoRequest({
    required this.assets,
    required this.name,
    required this.phone,
  });

  factory MyInfoRequest.fromJson(Map<String, dynamic> json) => MyInfoRequest(
        assets: json["assets"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "assets": assets,
        "name": name,
        "phone": phone,
      };
}
