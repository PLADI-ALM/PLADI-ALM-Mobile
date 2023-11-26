class LoginRequest {
  String email;
  String password;
  String fcmToken;

  LoginRequest({
    required this.email,
    required this.password,
    required this.fcmToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        email: json["email"],
        password: json["password"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "fcmToken": fcmToken};
}
