import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatelessWidget {
  final String link;

  DetailPage({required this.link});

  @override
  Widget build(BuildContext context) {
    if (link == '' || link[4] != 's') {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(child: Text('URL 정보가 없습니다.')),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(), //뒤로가기 버튼을 위해
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(link), // WebUri 생성자에 직접 URL 문자열 전달
        ),
        onLoadStart: (controller, url) {
          print("Started loading: $url");
        },
        onLoadStop: (controller, url) {
          print("Finished loading: $url");
        },
        onProgressChanged: (controller, progress) {
          // 로딩 중 진행 상태를 확인
          print("Loading progress: $progress%");
        },
      ),
    );
  }
}
