import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:regional_search_app/regional.dart';

void main() {
  test('test', () {
    String dummyData = """
{
      "title": "청라1동행정복지센터",
      "link": "http://www.seo.incheon.kr/cheongna/",
      "category": "공공,사회기관>행정복지센터",
      "description": "",
      "telephone": "",
      "address": "인천광역시 서구 청라동 165-5",
      "roadAddress": "인천광역시 서구 청라라임로 58",
      "mapx": "1266537441",
      "mapy": "375326783"
    }
""";
    Map<String, dynamic> map = jsonDecode(dummyData);
    Regional regional = Regional.fromJson(map);
    expect(regional.title, '청라1동행정복지센터');
    print(regional.toJson());
  });
}
