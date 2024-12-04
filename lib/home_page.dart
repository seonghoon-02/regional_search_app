import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          maxLines: 1,
          controller: textEditingController,
          // onSubmitted: (){},sssssssssssss
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 11, vertical: 11), // TextField 내부 높이 조정
            hintText: '검색어를 입력해 주세요',
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
          child: ListView.separated(
            itemCount: 10, // 리스트 항목 수
            itemBuilder: (context, index) {
              // 각 항목의 UI 정의
              return listContainer(index);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        )
      ])),
    );
  }

  Widget listContainer(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '삼성1동 주민센터',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '공공,사회기관>행정복지센터',
              style: TextStyle(fontSize: 14),
            ),
            Text('서울특별시 강남구 봉은사로 616 삼성1동 주민센터'),
          ],
        ),
      ),
    );
  }
}
