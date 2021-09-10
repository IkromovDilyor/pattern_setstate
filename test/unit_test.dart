import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/model/post_model.dart';
import 'package:state_management/services/http_service.dart';

void main() {
  test('Posts is not null', () async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response);
    expect(posts, null);
  });

  test('Posts is exactly 100', () async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response);
    expect(posts.length, equals(100));
  });

  test('Posts is greator  than zero', () async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response);
    expect(posts.length, greaterThan(0));
  });
}