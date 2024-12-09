import 'package:flutter/material.dart';
import 'package:regional_search_app/home_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regional_search_app/home_view_model.dart';
import 'package:regional_search_app/geolocator_helper.dart';
import 'package:regional_search_app/vworld_repository.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String locationName = ''; // 검색 키워드를 저장할 상태

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void search(String text) {
    ref.read(homeViewModelProvider.notifier).search(text);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider); // 상태를 관찰
    final vworldRepository = VworldRepository();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () async {
                String? localName =
                    await GeolocatorHelper.getAdministrativeArea();

                if (localName != null) {
                  textEditingController.text = localName;
                  search(localName);
                  setState(() {
                    locationName = localName; // 검색 키워드 상태 업데이트
                  });
                }
              },
              child: const SizedBox(
                width: 50,
                height: double.infinity,
                child: Icon(Icons.gps_fixed),
              ),
            ),
          ],
          title: TextField(
            onSubmitted: (String query) async {
              //TextField 에 입력된 키워드를 vworldRepository 이용하여 지역명으로 변환
              String foundTitle = await vworldRepository.findTitle(query);
              setState(() {
                locationName = foundTitle; // 검색 키워드 상태 업데이트
              });
              //변환된 지역명을 통해 서치api 호출
              search(foundTitle);
            },
            maxLines: 1,
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
              hintText: '검색어를 입력해 주세요',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              //지역 명으로 수정된 검색어 표시
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15),
                child: Text('검색어 : $locationName'),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 1)), // 2초 대기
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 로딩 상태일 때 로딩 표시
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      // 데이터가 없을 때 메시지 표시
                      return homeState.location == null ||
                              homeState.location!.isEmpty
                          ? Center(
                              child: Text(
                                locationName.isEmpty
                                    ? '검색 결과가 없습니다' // 기본 메시지
                                    : '검색 결과가 없습니다: $locationName', // 검색 키워드 포함
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                          : HomeListView(
                              locations: homeState.location!); // 데이터를 전달
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
