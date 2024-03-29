import 'package:flutter/material.dart';
import 'package:frontend/api/posts_api.dart';
import 'package:frontend/models/post.dart';
import 'package:frontend/shared_ui/list_posts.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PostsApi postsApi = PostsApi();
  List<Post>postsWithImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(color: Colors.redAccent),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: postsApi.fetchAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.none:
              return _error('No connection has been made');
              break;
            case ConnectionState.done:

              if(snapshot.hasError) {
                return _error(snapshot.error.toString());
              }

              if(! snapshot.hasData) {
                return _error('No Data fetched yet');
              }
              
              if(snapshot.hasData) {
                return _drawHomeScreen(snapshot.data);
              }
              break;
          }
          return Container();
        },
      )
    );
  }

  Widget _drawHomeScreen(List<Post> posts){
    for(Post post in posts){
      if(post.images.length > 0){
        postsWithImages.add(post);
      }
    }
    return Column(
      children: <Widget>[
        _slider(postsWithImages),
        _postsList(posts),
      ],
    );
  }

  Widget _slider(List<Post> posts){
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position){
          return InkWell(
            onTap: (){
              // TODO: Go to the single post screen
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      posts[position].images[0].image_url
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 8),
                      color: Colors.grey.withAlpha(100),
                      child: Text(posts[position].post_title,
                      style: TextStyle(
                        fontSize: 18
                      ),),
                    ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(error, style: TextStyle(color: Colors.red),),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _postsList(List<Post> posts) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position){
            return PostCard(posts[position]);
          },
        ),
      ),
    );
  }

}
