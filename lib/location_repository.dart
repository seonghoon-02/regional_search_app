import 'dart:convert';
import 'package:http/http.dart';
import 'package:regional_search_app/location.dart';

class LocationRepository {
  // 네이버 지역 검색 API로부터 데이터를 가져와 Location 객체 리스트로 반환
  Future<List<Location>> search(String query) async {
    try {
      Client client = Client();
      Response response = await client.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/local.json?query=$query&display=5'),
        headers: {
          'X-Naver-Client-Id': 'NQjTLWn4F9M5xZa8rtnR', // 네이버 클라이언트 ID
          'X-Naver-Client-Secret': 'vAyWh8FTfv', // 네이버 클라이언트 Secret
        },
      );

      // 응답 상태 코드 확인
      if (response.statusCode == 200) {
        // JSON 디코딩
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        // items 리스트 추출 및 Location 객체로 변환
        List<dynamic> items = decodedJson['items'];
        List<Location> locations = items.map((item) {
          return Location.fromJson(item);
        }).toList();

        return locations; // List<Location> 반환
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // 에러 로그 출력
      print('Error: $e');
      return [];
    }
  }
}
