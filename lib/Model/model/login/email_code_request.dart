class EmailCodeRequest {
  String email;
  String code;

  EmailCodeRequest({
    required this.email,
    required this.code,
  });

  factory EmailCodeRequest.fromJson(Map<String, dynamic> json) =>
      EmailCodeRequest(
        email: json["email"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}
