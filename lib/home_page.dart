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
    try {
      ref.read(homeViewModelProvider.notifier).search(text);
      print("search 성공");
    } catch (e) {
      print("Error during search: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (String query) {
              search(query);
              print(query);
            },
            maxLines: 1,
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 11, vertical: 11), // TextField 내부 높이 조정
              hintText: '검색어를 입력해 주세요',
              hintStyle: TextStyle(
                color: Colors.grey, // 힌트 텍스트 색상 설정
                fontSize: 14, // 힌트 텍스트 크기 설정
              ),
              border: MaterialStateOutlineInputBorder.resolveWith(
                (states) {
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    );
                  }
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                //ssssssssss
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: HomeListView(),
          )
        ])),
      ),
    );
  }
}
