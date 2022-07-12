class ImageData {
  String description;
  String altDescription;
  String url;

  ImageData({
    required this.description,
    required this.altDescription,
    required this.url,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
      description: (json["description"] != null)
          ? json["description"]
          : 'description is missing',
      altDescription:
          (json["name"] != null) ? json["name"] : 'alt_description is missing',
      url: (json["image"]["name"] != null)
          ? 'http://gallery.prod1.webant.ru/media/${json["image"]["name"]}'
          : 'images is missing');

  Map<String, dynamic> toJson() => {
        "description": description,
        "name": altDescription,
        "url": url,
      };
}
