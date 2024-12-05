import 'package:flutter_test/flutter_test.dart';
import 'package:regional_search_app/regional_repository.dart';

void main() {
  test('regional_repository_test', () async {
    RegionalRepository regionalRepository = RegionalRepository();
    final regional = await regionalRepository.search('청라동');
    expect(regional.isEmpty, false);
  });
}
