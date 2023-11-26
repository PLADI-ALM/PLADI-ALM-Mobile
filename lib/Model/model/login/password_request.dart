class PasswordRequest {
  String email;
  String password;

  PasswordRequest({
    required this.email,
    required this.password,
  });

  factory PasswordRequest.fromJson(Map<String, dynamic> json) =>
      PasswordRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
