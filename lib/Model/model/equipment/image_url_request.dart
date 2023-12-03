class ImageUrlRequest {
  String ext;
  String dir;

  ImageUrlRequest({
    required this.ext,
    required this.dir,
  });

  factory ImageUrlRequest.fromJson(Map<String, dynamic> json) =>
      ImageUrlRequest(
        ext: json["ext"],
        dir: json["dir"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "dir": dir,
      };
}
