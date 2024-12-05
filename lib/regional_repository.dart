import 'dart:convert';
import 'package:http/http.dart';
import 'package:regional_search_app/regional.dart';

class RegionalRepository {
  // 네이버 지역 검색 API로부터 데이터를 가져와 Regional 객체 리스트로 반환
  Future<List<Regional>> search(String query) async {
    try {
      Client client = Client();
      Response response = await client.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/local.json?query=$query'),
        headers: {
          'X-Naver-Client-Id': 'NQjTLWn4F9M5xZa8rtnR', // 네이버 클라이언트 ID
          'X-Naver-Client-Secret': 'vAyWh8FTfv', // 네이버 클라이언트 Secret
        },
      );

      // 응답 상태 코드 확인
      if (response.statusCode == 200) {
        // JSON 디코딩
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        // items 리스트 추출 및 Regional 객체로 변환
        List<dynamic> items = decodedJson['items'];
        List<Regional> regionals = items.map((item) {
          return Regional.fromJson(item);
        }).toList();

        return regionals; // List<Regional> 반환
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
