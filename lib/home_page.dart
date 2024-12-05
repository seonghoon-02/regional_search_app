import 'package:flutter/material.dart';
import 'package:regional_search_app/home_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:regional_search_app/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  void search(String text) {
    // 검색 수행
    ref.read(homeViewModelProvider.notifier).search(text);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider); // 상태를 관찰

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (String query) {
              search(query);
            },
            maxLines: 1,
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 11, vertical: 11),
              hintText: '검색어를 입력해 주세요',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: homeState.regional == null
                    ? Center(child: Text('검색 결과가 없습니다')) // 결과가 없을 때
                    : HomeListView(regionals: homeState.regional!), // 데이터를 전달
              ),
            ],
          ),
        ),
      ),
    );
  }
}
