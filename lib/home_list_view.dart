import 'package:flutter/material.dart';
import 'package:regional_search_app/detail_page.dart';
import 'package:regional_search_app/location.dart';

class HomeListView extends StatelessWidget {
  final List<Location> locations; // 데이터를 받아오는 필드 추가

  HomeListView({required this.locations}); // 데이터를 받는 생성자 추가

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: locations.length, // 항목 수를 데이터 개수로 설정
      itemBuilder: (context, index) {
        // 데이터를 이용해 각 항목 렌더링
        return listContainer(locations[index], context);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }

  Widget listContainer(Location location, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(link: location.link)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.title, // JSON에서 받아온 title 표시
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                location.category, // JSON에서 받아온 category 표시
                style: TextStyle(fontSize: 14),
              ),
              Text(location.roadAddress), // JSON에서 받아온 주소 표시
              //test위해 삽입
              // Text(location.link),
            ],
          ),
        ),
      ),
    );
  }
}
