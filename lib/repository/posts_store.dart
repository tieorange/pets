import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:adaptive_master_detail_layouts/domain/Post.dart';
import 'package:http/http.dart' as http;

part 'posts_store.g.dart';

class PostsStore = PostsStoreBase with _$PostsStore;

abstract class PostsStoreBase implements Store {
  @observable
  List<Post> postsList = [];

  @action
  getPosts() {
    fetchPosts().then((list) {
      postsList = list;
    });
  }

}

Future<List<Post>> fetchPosts() async {
  List<Post> posts = [];
  final response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    print('Item fetched: ${parsedJson.toString()}');
    return postsListFromJson(parsedJson);
  } else {
    throw Exception('Load failed');
  }
}
