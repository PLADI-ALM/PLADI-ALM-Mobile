class EmailRequest {
  String email;

  EmailRequest({
    required this.email,
  });

  factory EmailRequest.fromJson(Map<String, dynamic> json) => EmailRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
