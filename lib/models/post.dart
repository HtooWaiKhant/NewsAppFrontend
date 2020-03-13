import 'package:frontend/models/author.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/post_comment.dart';
import 'package:frontend/models/post_image.dart';
import 'package:frontend/models/post_tag.dart';

class Post {
  String post_id, post_title, post_content, post_type;
  String updated_at;
  List<PostImage> images;
  Category category;
  Author author;
  List<PostTag> tags;
  List<PostComment> comments;

  Post(this.post_id, this.post_title, this.post_content, this.post_type,
      this.updated_at, this.images, this.category, this.author, this.tags,
      this.comments);

  Post.fromJson( Map<String,dynamic> jsonObject ){
    this.post_id = jsonObject['post_id'].toString();
    this.post_title = jsonObject['post_title'].toString();
    this.post_content = jsonObject['post_content'].toString();
    this.post_type = jsonObject['post_type'].toString();
    this.updated_at = jsonObject['updated_at']; //DateTime.parse(jsonObject['updated_at']);
    this.images = [];
    for(var item in jsonObject['images']){
      images.add(PostImage.fromJson(item));
    }
    this.category = Category.fromJson(jsonObject['category']);
    this.author = Author.fromJson(jsonObject['author']);
    this.tags = [];
    for(var tag in jsonObject['tags']){
      tags.add(PostTag.fromJson(tag));
    }
    this.comments = [];
    for(var comment in jsonObject['comments']){
      comments.add(PostComment.fromJson(comment));
    }

  }


}