import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regional_search_app/location.dart';
import 'package:regional_search_app/location_repository.dart';

// 1. 화면에서 필요한 상태 만들기!
class HomeState {
  HomeState({required this.location});
  List<Location>? location;
}

// 2. 상태를 관리할 뷰모델 만들기! Notifier<뷰모델이 관리할 상태 클래스>
class HomeViewModel extends Notifier<HomeState> {
  // 3. build 함수 재정의 해서 초기상태 리턴해주기!
  @override
  HomeState build() {
    return HomeState(location: null);
  }

  // 4. Repository에서 데이터 받아와서 상태 업데이트 해주기!
  Future<void> search(String query) async {
    LocationRepository locationRepository = LocationRepository();
    state = HomeState(
      location: await locationRepository.search(query),
    );
  }
}

// 5. HomeViewModel을 관리할 관리자 만들어주기
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
