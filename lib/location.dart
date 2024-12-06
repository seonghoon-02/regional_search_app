class Location {
  final String title;
  final String link;
  final String category;
  final String roadAddress;

  Location(
      {required this.title,
      required this.link,
      required this.category,
      required this.roadAddress});

  Location.fromJson(Map<String, dynamic> json)
      : this(
          title: json["title"],
          link: json["link"],
          category: json["category"],
          roadAddress: json["roadAddress"],
        );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "category": category,
        "roadAddress": roadAddress
      };
}
