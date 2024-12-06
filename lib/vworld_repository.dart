import 'package:dio/dio.dart';

class VWorldRepository {
  final Dio _client = Dio(BaseOptions(
    // 설정안할 시 실패 응답 시 throw
    validateStatus: (status) => true,
  ));

  Future<List<String>> findByName(String query) async {
    final response = await _client.get(
      'https://api.vworld.kr/req/search',
      queryParameters: {
        'request': 'search',
        'key': 'D9A81EA7-97D4-39DF-AC1A-4C62DB0D8C25',
        'query': query,
        'type': 'DISTRICT',
        'category': 'L4',
        'size': 100, // Optional
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      // 행정주소 외 정보는 쓰지 않아서 모델생성 X(개인취향)
      // 써드파티 API(외부 API) 모델링 시 프로젝트에 외부 모델이 추가가되어 관리 힘듦
      return List.of(response.data['response']['result']['items'])
          .map((e) => e['title'].toString())
          .toList();
    }

    return [];
  }

  //gps 좌표로 행정구역 가져오기
  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    print('$lat ssssssss$lng sssssssssssssssssssssss');
    final response = await _client.get(
      'https://api.vworld.kr/req/data',
      queryParameters: {
        'request': 'GetFeature',
        'data': 'LT_C_ADEMD_INFO',
        'key': 'D9A81EA7-97D4-39DF-AC1A-4C62DB0D8C25',
        'geomfilter': 'point($lng $lat)',
        'geometry': 'false',
        'size': 100, // Optional
      },
    );

    if (response.statusCode == 200 &&
        response.data['response']['status'] == 'OK') {
      // 행정주소 외 정보는 쓰지 않아서 모델생성 X(개인취향)
      // 써드파티 API(외부 API) 모델링 시 프로젝트에 외부 모델이 추가가되어 관리 힘듦
      return List.of(response.data['response']['result']['featureCollection']
              ['features'])
          .map((e) => e['properties']['full_nm'].toString())
          .toList();
    }

    return [];
  }
}
