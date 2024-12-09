import 'package:geolocator/geolocator.dart';
import 'vworld_repository.dart';

class GeolocatorHelper {
  static bool _isDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  static Future<String?> getAdministrativeArea() async {
    // 위치 권한 확인 및 요청
    final permission = await Geolocator.checkPermission();
    if (_isDenied(permission)) {
      final request = await Geolocator.requestPermission();
      if (_isDenied(request)) {
        return null; // 권한이 없으면 null 반환
      }
    }

    try {
      // 현재 위치 가져오기
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // VWorldRepository 인스턴스 생성
      final vworldRepository = VworldRepository();

      // 좌표를 이용해 행정구역 데이터 가져오기
      final areas = await vworldRepository.findByLatLng(
        lat: position.latitude,
        lng: position.longitude,
      );
      // 가장 첫 번째 full_nm 반환 (리스트가 비었으면 null 반환)
      return areas.isNotEmpty ? areas.first : null;
    } catch (e) {
      print("getAdministrativeArea 함수 위치: $e");
      return null; // 에러 발생 시 null 반환
    }
  }
}
