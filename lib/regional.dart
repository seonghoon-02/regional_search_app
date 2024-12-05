// {
//       "title": "청라1동행정복지센터",
//       "link": "http://www.seo.incheon.kr/cheongna/",
//       "category": "공공,사회기관>행정복지센터",
//       "description": "",
//       "telephone": "",
//       "address": "인천광역시 서구 청라동 165-5",
//       "roadAddress": "인천광역시 서구 청라라임로 58",
//       "mapx": "1266537441",
//       "mapy": "375326783"
//     }

class Regional {
  final String title;
  final String link;
  final String category;
  final String roadAddress;

  Regional(
      {required this.title,
      required this.link,
      required this.category,
      required this.roadAddress});

  Regional.fromJson(Map<String, dynamic> json)
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
