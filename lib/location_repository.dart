import 'package:dio/dio.dart';
import 'package:regional_search_app/location.dart';

class LocationRepository {
  // 네이버 지역 검색 API로부터 데이터를 가져와 Location 객체 리스트로 반환
  Future<List<Location>> search(String query) async {
    try {
      // Dio 객체 초기화
      Dio dio = Dio();

      // API 요청
      Response response = await dio.get(
        'https://openapi.naver.com/v1/search/local.json',
        queryParameters: {
          'query': query,
          'display': 5, // 최대 5개 결과 표시
        },
        options: Options(
          headers: {
            'X-Naver-Client-Id': 'NQjTLWn4F9M5xZa8rtnR', // 네이버 클라이언트 ID
            'X-Naver-Client-Secret': 'vAyWh8FTfv', // 네이버 클라이언트 Secret
          },
        ),
      );

      // 응답 상태 코드 확인
      if (response.statusCode == 200) {
        // JSON 데이터 추출
        List<dynamic> items = response.data['items'];

        // Location 객체로 변환
        List<Location> locations = items.map((item) {
          return Location.fromJson(item);
        }).toList();

        return locations; // List<Location> 반환
      } else {
        print('Request failed: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // 에러 로그 출력
      print('Error: $e');
      return [];
    }
  }
}
