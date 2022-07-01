class Data {
  // String id;
  String description;
  String altDescription;
  String url;

  Data({
    // required this.id,
    required this.description,
    required this.altDescription,
    required this.url,
  });

  // factory Data.fromJson(Map<String, dynamic> json) => Data(
  //       // id: json["id"],
  //       description: (json["description"] != null)
  //           ? json["description"]
  //           : 'description is missing',
  //       altDescription: (json["alt_description"] != null)
  //           ? json["alt_description"]
  //           : 'alt_description is missing',
  //       url: (json["urls"]["full"] != null)
  //           ? json["urls"]["full"]
  //           : 'image is missing',
  //     );

  // Map<String, dynamic> toJson() => {
  //       // "id": id,
  //       "description": description,
  //       "alt_description": altDescription,
  //       "url": url,
  //     };

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        // id: json["id"],
        description: (json["description"] != null)
            ? json["description"]
            : 'description is missing',
        altDescription: (json["name"] != null)
            ? json["name"]
            : 'alt_description is missing',
        url: (json["image"]["name"] != null)
            ? json["image"]["name"]
            : 'image is missing',
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "description": description,
        "name": altDescription,
        "url": url,
      };
}
