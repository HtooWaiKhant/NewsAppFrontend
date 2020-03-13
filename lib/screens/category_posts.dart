import 'package:flutter/material.dart';
import 'package:frontend/api/categories_api.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/shared_ui/list_posts.dart';
import 'package:http/http.dart';

class CategoryPosts extends StatefulWidget {
  final String categoryID;

  CategoryPosts(this.categoryID);

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {

  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
        future: categoriesApi.fetchPostsForCategory(widget.categoryID),
        builder: ( BuildContext context , AsyncSnapshot<List<Post>> snapshot){
          print(snapshot);
          switch(snapshot.connectionState){
            case ConnectionState.active:
            //STILL WORKING
            return _loading();
            break;
            case ConnectionState.waiting:
            //STILL WORKING
            return _loading();
            break;
            case ConnectionState.none:
            //ERROR
            return _error('No Connection has been made');
            break;
            case ConnectionState.done:
            //COMPLETE
            if(snapshot.hasError){
            return _error(snapshot.error.toString());
            }

            if(snapshot.hasData){
            return _drawPostsList(snapshot.data);
            }
            break;
          }
          return Container();
      },
      ),
      ),
    );
  }


  Widget _error(String error){
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),),
      ),
    );
  }

  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
}

Widget _drawPostsList(List<Post> posts) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int position) {
      return PostCard(posts[position]);
    },),
  );
}


