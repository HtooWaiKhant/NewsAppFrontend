import 'dart:convert';

import 'package:frontend/models/post.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';

class PostsApi{
  Future<List<Post>> fetchAllPosts() async{
    String allPosts = ApiUtil.MAIN_API_URL + ApiUtil.All_POSTS;

    const Map<String, String> headers = {
      'Accept': 'application/json',
    };

    var response = await http.get(allPosts, headers: headers);
    List<Post> posts = [];

    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['data']){
        Post post = Post.fromJson(item);
        posts.add(post);
      }
    }
    return posts;
  }
}